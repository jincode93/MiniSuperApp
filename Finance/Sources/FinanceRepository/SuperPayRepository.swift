//
//  SuperPayRepository.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/20.
//

import Combine
import CombineUtil
import Foundation
import Network

public protocol SuperPayRepository {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    
    func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error>
}

public final class SuperPayRepositoryImp: SuperPayRepository {
    public var balance: ReadOnlyCurrentValuePublisher<Double> { balanceSubject }
    private let balanceSubject = CurrentValuePublisher<Double>(0)
    
    public func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error> {
        let request = TopupRequest(baseURL: baseURL, amount: amount, paymentMethodID: paymentMethodID)
        
        return network.send(request)
        // 실제 백엔드가 없기때문에 신호만 받아와서 핸들러로 실제 동작하는 것처럼 작성
            .handleEvents(
                receiveSubscription: nil,
                receiveOutput: { [weak self] _ in
                    let newBalance = (self?.balanceSubject.value).map { $0 + amount }
                    newBalance.map { self?.balanceSubject.send($0) }
                },
                receiveCompletion: nil,
                receiveCancel: nil,
                receiveRequest: nil
            )
            .map({ _ in })
            .eraseToAnyPublisher()
    }
    
    private let network: Network
    private let baseURL: URL
    
    public init(network: Network, baseURL: URL) {
        self.network = network
        self.baseURL = baseURL
    }
}
