//
//  AppCoordinator.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 15.07.2024.
//

import UIKit

/// протокол координатора
/// от него должны наследоваться все координаторы в этом прложении
public protocol FlowCoordinator: AnyObject {
    /// показ экрана
    func start()
}


final class AppCoordinator: FlowCoordinator {
    
    private weak var window: UIWindow?
    
    /// DI
    private let keychainBearerManager: KeychainBearerProtocol
    
    /// Сборки Assembly's
    private let loginAssembly: LoginAssembly
    private let mainTabBarAssembly: MainTabBarAssembly
    
    init(window: UIWindow?, keychainBearerManager: KeychainBearerProtocol, loginAssembly: LoginAssembly, mainTabBarAssembly: MainTabBarAssembly) {
        self.window = window
        self.keychainBearerManager = keychainBearerManager
        self.loginAssembly = loginAssembly
        self.mainTabBarAssembly = mainTabBarAssembly
    }
    
    func start() {
        animationConfigure()
        if keychainBearerManager.getToken() != nil {
            window?.rootViewController = mainTabBarAssembly.assemble()
        } else {
            let viewController = UINavigationController(rootViewController: loginAssembly.assemble())
            window?.rootViewController = viewController
        }
    }
    
    private func animationConfigure() {
        if let window {
            UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
