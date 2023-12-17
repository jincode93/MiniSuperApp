//
//  TransportHomeBuilder.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import ModernRIBs

protocol TransportHomeDependency: Dependency {
}

final class TransportHomeComponent: Component<TransportHomeDependency> {
    
}

protocol TransportHomeBuildable: Buildable {
    func build(withListener listener: TransportHomeListener) -> TransportHomeRouting
}

final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {
    
    override init(dependency: TransportHomeDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: TransportHomeListener) -> TransportHomeRouting {
        _ = TransportHomeComponent(dependency: dependency)
        
        let viewController = TransportHomeViewController()
        
        let interactor = TransportHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        return TransportHomeRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
