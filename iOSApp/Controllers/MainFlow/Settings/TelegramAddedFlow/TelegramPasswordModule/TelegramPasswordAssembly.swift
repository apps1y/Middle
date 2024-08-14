//
//  TelegramPasswordAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit
import NetworkAPI

final class TelegramPasswordAssembly {
    
    /// DI
    private let networkSevice: NetworkTelegramProtocol
    private let alertFabric: AlertFabric
    private let keychainManager: KeychainManager
    
    /// appCoordinator для выхода из сессии при неправильном запросе
    weak var coordinator: FlowCoordinator?
    
    init(networkSevice: NetworkTelegramProtocol, alertFabric: AlertFabric, keychainManager: KeychainManager) {
        self.networkSevice = networkSevice
        self.alertFabric = alertFabric
        self.keychainManager = keychainManager
    }
    
    func assemble(phoneNumber: String, oneTimeCode: String) -> TelegramPasswordViewController {
        let router = TelegramPasswordRouter(alertFabric: alertFabric)
        let viewController = TelegramPasswordViewController()
        let presenter = TelegramPasswordPresenter(view: viewController, router: router, networkSevice: networkSevice, keychainManager: keychainManager, coordinator: coordinator, phoneNumber: phoneNumber, oneTimeCode: oneTimeCode)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
