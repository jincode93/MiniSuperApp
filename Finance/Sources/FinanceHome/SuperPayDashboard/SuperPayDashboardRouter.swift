//
//  SuperPayDashboardRouter.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import ModernRIBs

protocol SuperPayDashboardInteractable: Interactable {
    var router: SuperPayDashboardRouting? { get set }
    var listener: SuperPayDashboardListener? { get set }
}

protocol SuperPayDashboardViewControllable: ViewControllable {
}

final class SuperPayDashboardRouter: ViewableRouter<SuperPayDashboardInteractable, SuperPayDashboardViewControllable>, SuperPayDashboardRouting {

    override init(interactor: SuperPayDashboardInteractable, viewController: SuperPayDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
