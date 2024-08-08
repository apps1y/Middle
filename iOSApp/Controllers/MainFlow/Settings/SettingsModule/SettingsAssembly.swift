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
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(networkService: NetworkMainProtocol, keychainBearerManager: KeychainBearerProtocol, coordinator: FlowCoordinator? = nil) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.coordinator = coordinator
    }
    
    func assemble() -> SettingsViewController {
        let router = SettingsRouter()
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
