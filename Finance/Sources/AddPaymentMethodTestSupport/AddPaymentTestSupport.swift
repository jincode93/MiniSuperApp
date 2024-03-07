//
//  File.swift
//  
//
//  Created by Zerom on 3/7/24.
//

import Foundation
import AddPaymentMethod
import ModernRIBs
import RIBsUtil
import RIBsTestSupport

public final class AddPaymentMethodBuildableMock: AddPaymentMethodBuildable {
    
    public var buildCallCount = 0
    public var closeButtonType: DismissButtonType?
    public func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> ViewableRouting {
        buildCallCount += 1
        self.closeButtonType = closeButtonType
        
        return ViewableRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
    }
    
    public init() { }
}
