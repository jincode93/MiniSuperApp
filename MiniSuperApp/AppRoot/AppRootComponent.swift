//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/21.
//

import AddPaymentMethod
import AddPaymentMethodImp
import AppHome
import FinanceHome
import FinanceRepository
import Foundation
import Network
import NetworkImp
import ModernRIBs
import ProfileHome
import TransportHome
import TransportHomeImp
import Topup
import TopupImp

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency, AddPaymentMethodDependency {
    
    var cardOnFileRepository: CardOnFileRepository
    var superPayRepository: SuperPayRepository
    
    lazy var transportHomeBuildable: TransportHomeBuildable = {
        return TransportHomeBuilder(dependency: self)
    }()
    
    lazy var topupBuildable: TopupBuildable = {
        return TopupBuilder(dependency: self)
    }()
    
    var topupBaseViewController: ViewControllable { rootViewController.topViewControllable }
    
    private var rootViewController: ViewControllable
    
    lazy var addPaymentMethodBuildable: AddPaymentMethodBuildable = {
        return AddPaymentMethodBuilder(dependency: self)
    }()
    
    init(
        dependency: AppRootDependency,
        rootViewController: ViewControllable
    ) {
        // 백엔드가 없는 상황에서 실제 서버에서 response를 받아오는 것처럼 동작시키기 위해 설정
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [SuperAppURLProtocol.self]
        
        setupURLProtocol()
        
        let network = NetworkImp(session: URLSession(configuration: config))
        
        self.cardOnFileRepository = CardOnFileRepositoryImp(network: network, baseURL: BaseURL().financeBaceURL)
        self.cardOnFileRepository.fetch()
        
        self.superPayRepository = SuperPayRepositoryImp(network: network, baseURL: BaseURL().financeBaceURL)
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}
