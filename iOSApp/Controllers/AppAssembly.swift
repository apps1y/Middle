//
//  AppAssembly.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 15.07.2024.
//

import UIKit
import NetworkAPI

final class AppAssembly {
    
    static func assemble(window: UIWindow?) -> FlowCoordinator {
        
        // MARK: - DI
        /// NetworkLayer
        /// Для тестирования есть `NetworkServiceStub`
        let networkService = NetworkService()
        /// uncomment next line to use network stubs
        // let networkStub = NetworkServiceStub()
        
        
        /// StorageLayer
        let databaseManager = DatabaseManager()
        
        let keychainManager = KeychainStub()
        // let keychainManager = KeychainManager()
        
        
        /// ManagersLayer
        let stringsValidationManager = StringsValidationManager()
        
        /// Fabrics
        let alertFabric = AlertFabric()
        
        
        // MARK: - Assembly сборки Auth Flow
        /// регистрация
        let confirmAssembly = ConfirmAssembly(networkService: networkService, keychainBearerManager: keychainManager, alertFabric: alertFabric)
        
        let passwordAssembly = PasswordAssembly(networkService: networkService, stringsValidation: stringsValidationManager, confirmAssembly: confirmAssembly, alertFabric: alertFabric)
        
        let emailAssembly = EmailAssembly(stringsValidation: stringsValidationManager, networkService: networkService, passwordAssembly: passwordAssembly, alertFabric: alertFabric)
        
        /// восстановление
        let newPasswordRecAssembly = NewPasswordRecAssembly(networkService: networkService, keychainBearerManager: keychainManager, stringsValidation: stringsValidationManager, alertFabric: alertFabric)
        
        let confirmRecAssembly = ConfirmRecAssembly(networkService: networkService, newPasswordRecAssembly: newPasswordRecAssembly, alertFabric: alertFabric)
        
        let emailRecAssembly = EmailRecAssembly(networkService: networkService, stringsValidation: stringsValidationManager, confirmRecAssembly: confirmRecAssembly, alertFabric: alertFabric)
        
        /// вход
        let loginAssembly = LoginAssembly(networkService: networkService, keychainBearerManager: keychainManager,
                                          stringsValidation: stringsValidationManager, emailAssembly: emailAssembly,
                                          emailRecAssembly: emailRecAssembly, confirmAssembly: confirmAssembly, alertFabric: alertFabric)
        
        
        
        // MARK: - Assembly сборки Main Flow
        let homeAssembly = HomeAssembly(networkService: networkService, databasePreviewsManager: databaseManager)

        let settingsAssembly = SettingsAssembly(networkService: networkService, keychainBearerManager: keychainManager)
        
        let tabBarController = MainTabBarController(homeAssembly: homeAssembly, settingsAssembly: settingsAssembly)
        
        
        
        // MARK: - App Coordinator
        let appCoordinator = AppCoordinator(window: window, keychainBearerManager: keychainManager, loginAssembly: loginAssembly, tabBarController: tabBarController)
        
        /// coordinator's DI
        loginAssembly.coordinator = appCoordinator
        confirmAssembly.coordinator = appCoordinator
        newPasswordRecAssembly.coordinator = appCoordinator
        
        return appCoordinator
    }
}
