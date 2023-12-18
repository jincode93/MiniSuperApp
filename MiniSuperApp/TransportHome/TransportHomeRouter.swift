//
//  TransportHomeRouter.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import ModernRIBs

protocol TransportHomeInteractable: Interactable {
    var router: TransportHomeRouting? { get set }
    var listener: TransportHomeListener? { get set }
}

protocol TransportHomeViewControllable: ViewControllable {
}

final class TransportHomeRouter: ViewableRouter<TransportHomeInteractable, TransportHomeViewControllable>, TransportHomeRouting {
    
    override init(
        interactor: TransportHomeInteractable,
        viewController: TransportHomeViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
