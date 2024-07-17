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
    }
    
    func start() {
        if let key = keychainBearerManager.getKey() {
            // прокинуть этот ключ в MainFlow
            window?.rootViewController = tabBarController
        } else {
            
        }
    }
}
