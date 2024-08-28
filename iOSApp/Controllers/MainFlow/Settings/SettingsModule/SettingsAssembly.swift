//
//  SettingsAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

final class SettingsAssembly {
    
    private let networkService:  NetworkTelegramProtocol & NetworkProfileProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let alertFabric: AlertFabric
    private let cashingRepository: CashingRepositoryProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    private let repasswordPreviewAssembly: RepasswordPreviewAssembly
    
    init(networkService: NetworkTelegramProtocol & NetworkProfileProtocol, keychainBearerManager: KeychainBearerProtocol, alertFabric: AlertFabric, cashingRepository: CashingRepositoryProtocol, coordinator: FlowCoordinator? = nil, repasswordPreviewAssembly: RepasswordPreviewAssembly) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.alertFabric = alertFabric
        self.cashingRepository = cashingRepository
        self.coordinator = coordinator
        self.repasswordPreviewAssembly = repasswordPreviewAssembly
    }
    
    func assemble() -> SettingsViewController {
        let router = SettingsRouter(repasswordPreviewAssembly: repasswordPreviewAssembly, alertFabric: alertFabric)
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, cashingRepository: cashingRepository, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
