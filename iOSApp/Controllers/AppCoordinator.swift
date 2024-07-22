//
//  AppCoordinator.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 15.07.2024.
//

import UIKit


public protocol FlowCoordinator: AnyObject {
    func start()
}


final class AppCoordinator: FlowCoordinator {
    
    private weak var window: UIWindow?
    
    /// DI
    private let keychainBearerManager: KeychainBearerProtocol
    
    /// Сборки Assembly's
    private let loginAssembly: LoginAssembly
    private let tabBarController: MainTabBarController
    
    init(window: UIWindow?, keychainBearerManager: KeychainManager, loginAssembly: LoginAssembly, tabBarController: MainTabBarController) {
        self.window = window
        self.keychainBearerManager = keychainBearerManager
        self.loginAssembly = loginAssembly
        self.tabBarController = tabBarController
        
        animationConfigure()
    }
    
    func start() {
        if keychainBearerManager.getKey() != nil {
            mainFlow()
        } else {
            authFlow()
        }
    }
    
    private func mainFlow() {
        tabBarController.setup { [weak self] in
            self?.start()
        }
        window?.rootViewController = tabBarController
    }
    
    private func authFlow() {
        let vc = loginAssembly.assemble()
        let navVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVC
    }
    
    private func animationConfigure() {
        if let window {
            UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
