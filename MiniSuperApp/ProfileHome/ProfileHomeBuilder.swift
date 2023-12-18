//
//  ProfileHomeBuilder.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import ModernRIBs

protocol ProfileHomeDependency: Dependency {
}

final class ProfileHomeComponent: Component<ProfileHomeDependency> {
}

protocol ProfileHomeBuildable: Buildable {
  func build(withListener listener: ProfileHomeListener) -> ProfileHomeRouting
}

final class ProfileHomeBuilder: Builder<ProfileHomeDependency>, ProfileHomeBuildable {
  
  override init(dependency: ProfileHomeDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: ProfileHomeListener) -> ProfileHomeRouting {
    let _ = ProfileHomeComponent(dependency: dependency)
    let viewController = ProfileHomeViewController()
    let interactor = ProfileHomeInteractor(presenter: viewController)
    interactor.listener = listener
    return ProfileHomeRouter(interactor: interactor, viewController: viewController)
  }
}
