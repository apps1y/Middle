//
//  SettingsAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

final class SettingsAssembly {
    
    private let networkService: NetworkMainProtocol & NetworkRecoverProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let alertFabric: AlertFabric
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    private let telegramAddAssembly: TelegramAddAssembly
    private var confirmRecAssembly: ConfirmRecAssembly
    
    init(networkService: NetworkMainProtocol & NetworkRecoverProtocol, keychainBearerManager: KeychainBearerProtocol, alertFabric: AlertFabric, coordinator: FlowCoordinator? = nil, telegramAddAssembly: TelegramAddAssembly, confirmRecAssembly: ConfirmRecAssembly) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.alertFabric = alertFabric
        self.coordinator = coordinator
        self.telegramAddAssembly = telegramAddAssembly
        self.confirmRecAssembly = confirmRecAssembly
    }
    
    func assemble() -> SettingsViewController {
        let router = SettingsRouter(telegramAddAssembly: telegramAddAssembly, confirmRecAssembly: confirmRecAssembly)
        let viewController = SettingsViewController(alertFabric: alertFabric)
        let presenter = SettingsPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
