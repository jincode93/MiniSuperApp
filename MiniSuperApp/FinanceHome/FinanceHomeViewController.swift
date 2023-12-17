//
//  FinanceHomeViewController.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import ModernRIBs
import UIKit

protocol FinanceHomePresentableListener: AnyObject {
}

final class FinanceHomeViewController: UIViewController, FinanceHomePresentable, FinanceHomeViewControllable {
    
    weak var listener: FinanceHomePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        title = "슈퍼페이"
        tabBarItem = UITabBarItem(title: "슈퍼페이", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(systemName: "creditcard.fill"))
        label.text = "Finance Home"
        view.backgroundColor = .systemBlue
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
