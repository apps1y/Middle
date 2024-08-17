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
        // let networkService = NetworkServiceStub()
        
        
        /// StorageLayer
        let coreDaraService = CoreDataService()
        
        // let keychainManager = KeychainStub()
        let keychainManager = KeychainManager()
        
        let userDefaultsManager = UserDefaultsManager()
        
        /// ManagersLayer
        let stringsValidationManager = StringsValidationManager()
        
        /// Fabrics
        let alertFabric = AlertFabric()
        
        let cashingRepository = CashingRepository(userDefaultsManager: userDefaultsManager, coreDataService: coreDaraService)
        
        
        
        
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
        let homeAssembly = HomeAssembly(networkService: networkService, coreDataService: coreDaraService)
        
        let telegramPasswordAssembly = TelegramPasswordAssembly(networkSevice: networkService, alertFabric: alertFabric, keychainManager: keychainManager, cashingRepository: cashingRepository)
        let telegramCodeAssembly = TelegramCodeAssembly(telegramPasswordAssembly: telegramPasswordAssembly)
        let telegramNumberAssembly = TelegramNumberAssembly(networkSevice: networkService, alertFabric: alertFabric, keychainManager: keychainManager, cashingRepository: cashingRepository, telegramCodeAssembly: telegramCodeAssembly)

        let repasswordPreviewAssembly = RepasswordPreviewAssembly(networkService: networkService, alertFabric: alertFabric, confirmRecAssembly: confirmRecAssembly)
        
        let settingsAssembly = SettingsAssembly(networkService: networkService, keychainBearerManager: keychainManager, alertFabric: alertFabric, cashingRepository: cashingRepository, telegramNumberAssembly: telegramNumberAssembly, repasswordPreviewAssembly: repasswordPreviewAssembly)
        
        let mainTabBarAssembly = MainTabBarAssembly(homeAssembly: homeAssembly, settingsAssembly: settingsAssembly)
        
        
        // MARK: - App Coordinator
        let appCoordinator = AppCoordinator(window: window, keychainBearerManager: keychainManager, loginAssembly: loginAssembly, mainTabBarAssembly: mainTabBarAssembly)
        
        /// appCoordinator's DI
        loginAssembly.coordinator = appCoordinator
        confirmAssembly.coordinator = appCoordinator
        newPasswordRecAssembly.coordinator = appCoordinator
        settingsAssembly.coordinator = appCoordinator
        
        telegramPasswordAssembly.coordinator = appCoordinator
        telegramNumberAssembly.coordinator = appCoordinator
        
        return appCoordinator
    }
}
