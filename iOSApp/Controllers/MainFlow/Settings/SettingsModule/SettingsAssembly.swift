//
//  SettingsAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

final class SettingsAssembly {
    
    private let networkService: NetworkTelegramProtocol & NetworkRecoverProtocol & NetworkProfileProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let alertFabric: AlertFabric
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    private let telegramAddAssembly: TelegramAddAssembly
    private var confirmRecAssembly: ConfirmRecAssembly
    
    init(networkService: NetworkTelegramProtocol & NetworkRecoverProtocol & NetworkProfileProtocol, keychainBearerManager: KeychainBearerProtocol, alertFabric: AlertFabric, coordinator: FlowCoordinator? = nil, telegramAddAssembly: TelegramAddAssembly, confirmRecAssembly: ConfirmRecAssembly) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.alertFabric = alertFabric
        self.coordinator = coordinator
        self.telegramAddAssembly = telegramAddAssembly
        self.confirmRecAssembly = confirmRecAssembly
    }
    
    func assemble() -> SettingsViewController {
        let router = SettingsRouter(telegramAddAssembly: telegramAddAssembly, confirmRecAssembly: confirmRecAssembly, alertFabric: alertFabric)
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
