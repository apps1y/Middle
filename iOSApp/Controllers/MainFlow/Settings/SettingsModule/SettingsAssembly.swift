//
//  SettingsAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

final class SettingsAssembly {
    
    private let networkService:  NetworkRecoverProtocol & NetworkProfileProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let alertFabric: AlertFabric
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    private let telegramNumberAssembly: TelegramNumberAssembly
    private var confirmRecAssembly: ConfirmRecAssembly
    
    init(networkService: NetworkRecoverProtocol & NetworkProfileProtocol, keychainBearerManager: KeychainBearerProtocol, alertFabric: AlertFabric, coordinator: FlowCoordinator? = nil, telegramNumberAssembly: TelegramNumberAssembly, confirmRecAssembly: ConfirmRecAssembly) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.alertFabric = alertFabric
        self.coordinator = coordinator
        self.telegramNumberAssembly = telegramNumberAssembly
        self.confirmRecAssembly = confirmRecAssembly
    }
    
    func assemble() -> SettingsViewController {
        let router = SettingsRouter(telegramNumberAssembly: telegramNumberAssembly, confirmRecAssembly: confirmRecAssembly, alertFabric: alertFabric)
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
