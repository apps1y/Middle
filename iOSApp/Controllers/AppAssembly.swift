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
        let authManager = AuthManager(keychainManager: keychainManager)
        
        
        // MARK: - Assembly сборки
        let emailAssembly = EmailAssembly(networkService: networkService, authManager: authManager, stringsValidation: stringsValidationManager)
        
        let loginAssembly = LoginAssembly(networkService: networkService, authManager: authManager, stringsValidation: stringsValidationManager, emailAssembly: emailAssembly)
        
        
        let appCoordinator = AppCoordinator(window: window, loginAssembly: loginAssembly)
        return appCoordinator
    }
}
