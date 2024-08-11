//
//  SettingsAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

final class SettingsAssembly {
    
    private let networkService: NetworkMainProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let alertFabric: AlertFabric
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    private let telegramAddAssembly: TelegramAddAssembly
    
    init(networkService: NetworkMainProtocol, keychainBearerManager: KeychainBearerProtocol, alertFabric: AlertFabric, coordinator: FlowCoordinator? = nil, telegramAddAssembly: TelegramAddAssembly) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.alertFabric = alertFabric
        self.coordinator = coordinator
        self.telegramAddAssembly = telegramAddAssembly
    }
    
    func assemble() -> SettingsViewController {
        let router = SettingsRouter(telegramAddAssembly: telegramAddAssembly)
        let viewController = SettingsViewController(alertFabric: alertFabric)
        let presenter = SettingsPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
