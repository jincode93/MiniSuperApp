//
//  File.swift
//  
//
//  Created by Zerom on 3/7/24.
//

import Foundation
import FinanceEntity
import RIBsTestSupport
@testable import TopupImp

final class CardOnFileBuildableMock: CardOnFileBuildable {
    
    var buildHandler: ((_ listener: CardOnFileListener) -> CardOnFileRouting)?
    
    var buildCallCount = 0
    var buildPaymentMethod: [PaymentMethod]?
    func build(withListener listener: CardOnFileListener, paymentMethods: [PaymentMethod]) -> CardOnFileRouting {
        buildCallCount += 1
        buildPaymentMethod = paymentMethods
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
    
    init() { }
}

final class CardOnFileRoutingMock: ViewableRoutingMock, CardOnFileRouting {
    
}
