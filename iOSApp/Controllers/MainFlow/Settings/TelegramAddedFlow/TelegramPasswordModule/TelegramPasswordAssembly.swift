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
    private let cashingRepository: CashingRepositoryProtocol
    
    /// appCoordinator для выхода из сессии при неправильном запросе
    weak var coordinator: FlowCoordinator?
    
    init(networkSevice: NetworkTelegramProtocol, alertFabric: AlertFabric, keychainManager: KeychainManager, cashingRepository: CashingRepositoryProtocol) {
        self.networkSevice = networkSevice
        self.alertFabric = alertFabric
        self.keychainManager = keychainManager
        self.cashingRepository = cashingRepository
    }
    
    func assemble(phoneNumber: String, oneTimeCode: String, completion: @escaping (TelegramAccountModel) -> Void) -> TelegramPasswordViewController {
        let router = TelegramPasswordRouter(alertFabric: alertFabric, completion: completion)
        let viewController = TelegramPasswordViewController()
        let presenter = TelegramPasswordPresenter(view: viewController, router: router, networkSevice: networkSevice, keychainManager: keychainManager, cashingRepository: cashingRepository, coordinator: coordinator, phoneNumber: phoneNumber, oneTimeCode: oneTimeCode)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
