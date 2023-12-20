//
//  AdaptivePresentationControllerDelegate.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/18.
//

import UIKit

/*
모달을 닫을 때 Interactor를 통해서 닫아주는데 Interactor는 UIKit을 모르기 때문에
UIAdaptivePresentationControllerDelegate를 사용못함
Interactor에 UIKit에 대한 의존성을 만들기보다는 protocol을 통해서 해결해주기 위해 만듬
 */
public protocol AdaptivePresentationControllerDelegate: AnyObject {
    func presentationControllerDidDismiss()
}

public final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
    
    public weak var delegate: AdaptivePresentationControllerDelegate?
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDidDismiss()
    }
}
