//
//  FinanceHomeBuilder.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import ModernRIBs

protocol FinanceHomeDependency: Dependency {
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashboardDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
    private let balancePublisher: CurrentValuePublisher<Double>
    
    init(
        dependency: FinanceHomeDependency,
        balance: CurrentValuePublisher<Double>
    ) {
        self.balancePublisher = balance
        super.init(dependency: dependency)
    }
}

protocol FinanceHomeBuildable: Buildable {
    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
    
    override init(dependency: FinanceHomeDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
        let balancePublisher = CurrentValuePublisher<Double>(10000)
        
        let component = FinanceHomeComponent(
            dependency: dependency,
            balance: balancePublisher
        )
        let viewController = FinanceHomeViewController()
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
        
        return FinanceHomeRouter(
            interactor: interactor,
            viewController: viewController,
            superPayDashboardBuildable: superPayDashboardBuilder
        )
    }
}
