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
    private let cashingRepository: CashingRepositoryProtocol
    
    private var telegramCodeAssembly: TelegramCodeAssembly
    
    weak var coordinator: FlowCoordinator?
    
    init(networkSevice: NetworkTelegramProtocol, alertFabric: AlertFabric, keychainManager: KeychainManager, cashingRepository: CashingRepositoryProtocol, telegramCodeAssembly: TelegramCodeAssembly) {
        self.networkSevice = networkSevice
        self.alertFabric = alertFabric
        self.keychainManager = keychainManager
        self.cashingRepository = cashingRepository
        self.telegramCodeAssembly = telegramCodeAssembly
    }
    
    func assemble(completion: @escaping (TelegramAccountModel) -> Void) -> TelegramNumberViewController {
        let router = TelegramNumberRouter(telegramCodeAssembly: telegramCodeAssembly, completion: completion, alertFabric: alertFabric)
        let viewController = TelegramNumberViewController()
        let presenter = TelegramNumberPresenter(view: viewController, router: router, networkSevice: networkSevice, alertFabric: alertFabric, keychainManager: keychainManager, cashingRepository: cashingRepository, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
