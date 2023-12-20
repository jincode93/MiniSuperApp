//
//  TransportHomeRouter.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import ModernRIBs

protocol TransportHomeInteractable: Interactable, TopupListener {
    var router: TransportHomeRouting? { get set }
    var listener: TransportHomeListener? { get set }
}

protocol TransportHomeViewControllable: ViewControllable {
}

final class TransportHomeRouter: ViewableRouter<TransportHomeInteractable, TransportHomeViewControllable>, TransportHomeRouting {
    
    private let topupBuildable: TopupBuildable
    private var topupRouting: Routing?
    
    init(
        interactor: TransportHomeInteractable,
        topupBuildable: TopupBuildable,
        viewController: TransportHomeViewControllable
    ) {
        self.topupBuildable = topupBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTopup() {
        if topupRouting != nil { return }
        
        let router = topupBuildable.build(withListener: interactor)
        self.topupRouting = router
        attachChild(router)
    }
    
    func detachTopup() {
        guard let router = topupRouting else { return }
        detachChild(router)
        self.topupRouting = nil
    }
}
