//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/18.
//

import Combine
import ModernRIBs

protocol CardOnFileDashboardRouting: ViewableRouting {
}

protocol CardOnFileDashboardPresentable: Presentable {
    var listener: CardOnFileDashboardPresentableListener? { get set }
    
    func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
    func cardOnFileDashboardDidTappAddPaymentMethod()
}

protocol CardOnFileDashboardInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener?

    private let dependency: CardOnFileDashboardInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
    
    init(
        presenter: CardOnFileDashboardPresentable,
        dependency: CardOnFileDashboardInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.cardOnFileRepository.cardOnFile.sink { methods in
            let viewModels = methods.prefix(5).map(PaymentMethodViewModel.init)
            self.presenter.update(with: viewModels)
        }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func didTapAddPaymentMethod() {
        listener?.cardOnFileDashboardDidTappAddPaymentMethod()
    }
}
