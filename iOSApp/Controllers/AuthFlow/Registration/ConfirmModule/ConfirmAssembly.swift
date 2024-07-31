//
//  ConfirmAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit
import NetworkAPI

final class ConfirmAssembly {
    
    /// DI
    private var networkService: NetworkValidationProtocol
    private var keychainBearerManager: KeychainBearerProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    /// Fabrics
    private let alertFabric: AlertFabricProtocol
    
    init(networkService: NetworkValidationProtocol, keychainBearerManager: KeychainBearerProtocol, coordinator: FlowCoordinator? = nil, alertFabric: AlertFabricProtocol) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.coordinator = coordinator
        self.alertFabric = alertFabric
    }
    
    func assemble(token: String) -> ConfirmViewController {
        let viewController = ConfirmViewController()
        let router = ConfirmRouter(alertFabric: alertFabric)
        let presenter = ConfirmPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, coordinator: coordinator, token: token)
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
