//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/18.
//

import Combine
import CombineUtil
import FinanceEntity
import Foundation
import Network

public protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error>
    func fetch()
}

public final class CardOnFileRepositoryImp: CardOnFileRepository {
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
    
    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
//        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
//        PaymentMethod(id: "1", name: "신한카드", digits: "0987", color: "#3478f6ff", isPrimary: false),
//        PaymentMethod(id: "2", name: "현대카드", digits: "8121", color: "#78c5f5ff", isPrimary: false)
    ])
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        let request = AddCardRequest(baseURL: baseURL, info: info)
        
        return network.send(request)
            .map(\.output.card)
            // 현재 백엔드가 없기 때문에 백엔드 api에서 받아오는 것 처럼 해주기 위해 핸들링
            .handleEvents(
                receiveSubscription: nil,
                receiveOutput: { [weak self] method in
                    guard let this = self else { return }
                    
                    this.paymentMethodsSubject.send(this.paymentMethodsSubject.value + [method])
                },
                receiveCompletion: nil,
                receiveCancel: nil,
                receiveRequest: nil
            )
            .eraseToAnyPublisher()
    }
    
    public func fetch() {
        let request = CardOnFileRequest(baseURL: baseURL)
        network.send(request).map(\.output.cards)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] cards in
                    self?.paymentMethodsSubject.send(cards)
                }
            )
            .store(in: &cancellables)
    }
    
    private let network: Network
    private let baseURL: URL
    private var cancellables: Set<AnyCancellable>
    
    public init(network: Network, baseURL: URL) {
        self.network = network
        self.baseURL = baseURL
        self.cancellables = .init()
    }
}
