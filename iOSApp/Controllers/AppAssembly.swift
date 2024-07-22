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
        var passwordAssembly = PasswordAssembly(networkService: networkService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager)
        
        var passwordRecAssembly = PasswordRecAssembly(networkService: networkService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager)
        
        var emailRecAssembly = EmailRecAssembly(networkService: networkService, stringsValidation: stringsValidationManager, passwordRecAssembly: passwordRecAssembly)
        
        var confirmAssembly = ConfirmAssembly(networkService: networkService, passwordAssembly: passwordAssembly)
        
        var emailAssembly = EmailAssembly(networkService: networkService, stringsValidation: stringsValidationManager, confirmAssembly: confirmAssembly)
        
        var loginAssembly = LoginAssembly(networkService: networkService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager, emailAssembly: emailAssembly, emailRecAssembly: emailRecAssembly)
        
        
        
        // MARK: - Assembly сборки Main Flow
        var homeAssembly = HomeAssembly(networkService: networkService, databasePreviewsManager: databaseManager)

        var settingsAssembly = SettingsAssembly(networkService: networkService, keychainBearerManager: keychainManager)
        
        var tabBarController = MainTabBarController(homeAssembly: homeAssembly, settingsAssembly: settingsAssembly)
        
        
        
        // MARK: - App Coordinator
        var appCoordinator = AppCoordinator(window: window, keychainBearerManager: keychainManager, loginAssembly: loginAssembly, tabBarController: tabBarController)
        
        /// coordinator's DI
        loginAssembly.coordinator = appCoordinator
        
        return appCoordinator
    }
}
