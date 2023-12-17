//
//  AppComponent.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import Foundation
import ModernRIBs

final class AppComponent: Component<EmptyDependency>, AppRootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
