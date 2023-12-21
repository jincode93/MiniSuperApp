//
//  TransportHomeBuilder.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import CombineUtil
import FinanceRepository
import ModernRIBs
import Topup
import TransportHome

public protocol TransportHomeDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var superPayRepository: SuperPayRepository { get }
    var topupBuildable: TopupBuildable { get }
}

final class TransportHomeComponent: Component<TransportHomeDependency>, TransportHomeInteractorDependency {
    
    let topupBaseViewController: ViewControllable
    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
    var superPayBalance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
    var topupBuildable: TopupBuildable { dependency.topupBuildable }
    
    init(
        dependency: TransportHomeDependency,
        topupBaseViewController: ViewControllable
    ) {
        self.topupBaseViewController = topupBaseViewController
        super.init(dependency: dependency)
    }
}

public final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {
    
    public override init(dependency: TransportHomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: TransportHomeListener) -> ViewableRouting {
        
        let viewController = TransportHomeViewController()
        let component = TransportHomeComponent(dependency: dependency, topupBaseViewController: viewController)
        
        let interactor = TransportHomeInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        
        return TransportHomeRouter(
            interactor: interactor,
            topupBuildable: component.topupBuildable,
            viewController: viewController
        )
    }
}
