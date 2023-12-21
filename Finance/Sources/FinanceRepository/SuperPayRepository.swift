//
//  SuperPayRepository.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/20.
//

import Foundation
import Combine
import CombineUtil

public protocol SuperPayRepository {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    
    func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error>
}

public final class SuperPayRepositoryImp: SuperPayRepository {
    public var balance: ReadOnlyCurrentValuePublisher<Double> { balanceSubject }
    private let balanceSubject = CurrentValuePublisher<Double>(0)
    
    public func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            self?.bgQueue.async {
                Thread.sleep(forTimeInterval: 2)
                promise(.success(()))
                let newBalance = (self?.balanceSubject.value).map { $0 + amount }
                newBalance.map { self?.balanceSubject.send($0) }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // 현재는 실제 api가 없기 때문에 background Queue를 만들어서 딜레이를 걸어주는 방식으로 api 동작과 비슷하게 해줌
    private let bgQueue = DispatchQueue(label: "topup.repository.queue")
    
    public init() {
        
    }
}
