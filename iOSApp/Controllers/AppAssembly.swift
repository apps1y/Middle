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
        /// регистрация
        var confirmAssembly = ConfirmAssembly(networkService: networkService, keychainBearerManager: keychainManager)
        
        var passwordAssembly = PasswordAssembly(networkService: networkService, stringsValidation: stringsValidationManager, confirmAssembly: confirmAssembly)
        
        var emailAssembly = EmailAssembly(stringsValidation: stringsValidationManager, passwordAssembly: passwordAssembly)
        
        /// восстановление
        var newPasswordRecAssembly = NewPasswordRecAssembly(networkService: networkService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager)
        
        var confirmRecAssembly = ConfirmRecAssembly(networkService: networkService, newPasswordRecAssembly: newPasswordRecAssembly)
        
        var emailRecAssembly = EmailRecAssembly(networkService: networkService, stringsValidation: stringsValidationManager, confirmRecAssembly: confirmRecAssembly)
        
        var loginAssembly = LoginAssembly(networkService: networkService, keychainBearerManager: keychainManager, 
                                          stringsValidation: stringsValidationManager, emailAssembly: emailAssembly,
                                          emailRecAssembly: emailRecAssembly, confirmAssembly: confirmAssembly)
        
        
        
        // MARK: - Assembly сборки Main Flow
        var homeAssembly = HomeAssembly(networkService: networkService, databasePreviewsManager: databaseManager)

        var settingsAssembly = SettingsAssembly(networkService: networkService, keychainBearerManager: keychainManager)
        
        var tabBarController = MainTabBarController(homeAssembly: homeAssembly, settingsAssembly: settingsAssembly)
        
        
        
        // MARK: - App Coordinator
        var appCoordinator = AppCoordinator(window: window, keychainBearerManager: keychainManager, loginAssembly: loginAssembly, tabBarController: tabBarController)
        
        /// coordinator's DI
        loginAssembly.coordinator = appCoordinator
        confirmAssembly.coordinator = appCoordinator
        newPasswordRecAssembly.coordinator = appCoordinator
        
        return appCoordinator
    }
}
