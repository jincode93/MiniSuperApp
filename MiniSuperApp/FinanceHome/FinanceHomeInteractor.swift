//
//  FinanceHomeInteractor.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import ModernRIBs

protocol FinanceHomeRouting: ViewableRouting {
    func attachSuperPayDashboard()
}

protocol FinanceHomePresentable: Presentable {
    var listener: FinanceHomePresentableListener? { get set }
}

protocol FinanceHomeListener: AnyObject {
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable, FinanceHomePresentableListener {
    
    weak var router: FinanceHomeRouting?
    weak var listener: FinanceHomeListener?
    
    override init(presenter: FinanceHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()

        router?.attachSuperPayDashboard()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
}
