//
//  FinanceHomeBuilder.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import ModernRIBs

protocol FinanceHomeDependency: Dependency {
}

final class FinanceHomeComponent: Component<FinanceHomeDependency> {
}

protocol FinanceHomeBuildable: Buildable {
    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
    
    override init(dependency: FinanceHomeDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
        let _ = FinanceHomeComponent(dependency: dependency)
        let viewController = FinanceHomeViewController()
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return FinanceHomeRouter(interactor: interactor, viewController: viewController)
    }
}
