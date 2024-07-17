//
//  AppAssembly.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 15.07.2024.
//

import UIKit

final class AppAssembly {
    
    static func assemble(window: UIWindow?) -> FlowCoordinator {
        
        // MARK: - DI
        /// NetworkLayer
        let networkAuthService = NetworkAuthService()
        
        /// StorageLayer
        let databaseManager = DatabaseManager()
        let keychainManager = KeychainManager()
        
        /// ManagersLayer
        let stringsValidationManager = StringsValidationManager()
        
        
        // MARK: - Assembly сборки Auth Flow
        let passwordAssembly = PasswordAssembly(networkService: networkAuthService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager)
        
        let passwordRecAssembly = PasswordRecAssembly(networkService: networkAuthService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager)
        
        let emailRecAssembly = EmailRecAssembly(networkService: networkAuthService, stringsValidation: stringsValidationManager, passwordRecAssembly: passwordRecAssembly)
        
        let emailAssembly = EmailAssembly(networkService: networkAuthService,
                                          stringsValidation: stringsValidationManager, passwordAssembly: passwordAssembly)
        
        let loginAssembly = LoginAssembly(networkService: networkAuthService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager, emailAssembly: emailAssembly, emailRecAssembly: emailRecAssembly)
        
        
        // MARK: - Assembly сборки Main Flow
        let tabBarController = MainTabBarController()
        
        
        // MARK: - App Coordinator
        let appCoordinator = AppCoordinator(window: window, keychainBearerManager: keychainManager, loginAssembly: loginAssembly, tabBarController: tabBarController)
        
        return appCoordinator
    }
}
