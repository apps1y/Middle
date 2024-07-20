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
        let networkService = NetworkService()
        
        /// StorageLayer
        let databaseManager = DatabaseManager()
        let keychainManager = KeychainManager()
        
        /// ManagersLayer
        let stringsValidationManager = StringsValidationManager()
        
        
        
        // MARK: - Assembly сборки Auth Flow
        let passwordAssembly = PasswordAssembly(networkService: networkService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager)
        
        let passwordRecAssembly = PasswordRecAssembly(networkService: networkService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager)
        
        let emailRecAssembly = EmailRecAssembly(networkService: networkService, stringsValidation: stringsValidationManager, passwordRecAssembly: passwordRecAssembly)
        
        let emailAssembly = EmailAssembly(networkService: networkService,
                                          stringsValidation: stringsValidationManager, passwordAssembly: passwordAssembly)
        
        let loginAssembly = LoginAssembly(networkService: networkService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager, emailAssembly: emailAssembly, emailRecAssembly: emailRecAssembly)
        
        
        
        // MARK: - Assembly сборки Main Flow
        let homeAssembly = HomeAssembly(networkService: networkService, databasePreviewsManager: databaseManager)

        let settingsAssembly = SettingsAssembly(networkService: networkService, keychainBearerManager: keychainManager)
        
        let tabBarController = MainTabBarController(homeAssembly: homeAssembly, settingsAssembly: settingsAssembly)
        
        
        
        // MARK: - App Coordinator
        let appCoordinator = AppCoordinator(window: window, keychainBearerManager: keychainManager, loginAssembly: loginAssembly, tabBarController: tabBarController)
        
        return appCoordinator
    }
}
