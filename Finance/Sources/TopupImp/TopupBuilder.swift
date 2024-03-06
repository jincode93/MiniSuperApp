//
//  TopupBuilder.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/18.
//

import AddPaymentMethod
import CombineUtil
import CombineSchedulers
import Foundation
import FinanceRepository
import FinanceEntity
import ModernRIBs
import Topup

public protocol TopupDependency: Dependency {
    var topupBaseViewController: ViewControllable { get }
    var cardOnFileRepository: CardOnFileRepository { get }
    var superPayRepository: SuperPayRepository { get }
    var addPaymentMethodBuildable: AddPaymentMethodBuildable { get }
    var mainQueue: AnySchedulerOf<DispatchQueue> { get }
}

final class TopupComponent: Component<TopupDependency>, TopupInteractorDependency, EnterAmountDependency, CardOnFileDependency {
    
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { paymentMethodStream }
    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
    var addPaymentMethodBuildable: AddPaymentMethodBuildable { dependency.addPaymentMethodBuildable }
    var mainQueue: AnySchedulerOf<DispatchQueue> { dependency.mainQueue }
    
    fileprivate var topupBaseViewController: ViewControllable { dependency.topupBaseViewController }
    
    let paymentMethodStream: CurrentValuePublisher<PaymentMethod>
    
    init(
        dependency: TopupDependency,
        paymentMethodStream: CurrentValuePublisher<PaymentMethod>
    ) {
        self.paymentMethodStream = paymentMethodStream
        super.init(dependency: dependency)
    }
}

public final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {

    public override init(dependency: TopupDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: TopupListener) -> Routing {
        let paymentMethodStream = CurrentValuePublisher(PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false))
        
        let component = TopupComponent(dependency: dependency, paymentMethodStream: paymentMethodStream)
        let interactor = TopupInteractor(dependency: component)
        interactor.listener = listener
    
        let enterAmountBuildable = EnterAmountBuilder(dependency: component)
        let cardOnFileBuildable = CardOnFileBuilder(dependency: component)
        
        return TopupRouter(
            interactor: interactor,
            viewController: component.topupBaseViewController,
            addPaymentMethodBuildable: component.addPaymentMethodBuildable,
            enterAmountBuildable: enterAmountBuildable,
            cardOnFileBuildable: cardOnFileBuildable
        )
    }
}
