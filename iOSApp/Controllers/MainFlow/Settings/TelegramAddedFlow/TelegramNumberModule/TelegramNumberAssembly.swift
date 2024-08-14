//
//  TelegramNumberAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit
import NetworkAPI

final class TelegramNumberAssembly {
    
    /// DI
    private let networkSevice: NetworkTelegramProtocol
    private let alertFabric: AlertFabric
    private let keychainManager: KeychainManager
    
    private var telegramCodeAssembly: TelegramCodeAssembly
    
    weak var coordinator: FlowCoordinator?
    
    init(networkSevice: NetworkTelegramProtocol, alertFabric: AlertFabric, keychainManager: KeychainManager, telegramCodeAssembly: TelegramCodeAssembly) {
        self.networkSevice = networkSevice
        self.alertFabric = alertFabric
        self.keychainManager = keychainManager
        self.telegramCodeAssembly = telegramCodeAssembly
    }
    
    func assemble() -> TelegramNumberViewController {
        let router = TelegramNumberRouter(telegramCodeAssembly: telegramCodeAssembly, alertFabric: alertFabric)
        let viewController = TelegramNumberViewController()
        let presenter = TelegramNumberPresenter(view: viewController, router: router, networkSevice: networkSevice, alertFabric: alertFabric, keychainManager: keychainManager, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
