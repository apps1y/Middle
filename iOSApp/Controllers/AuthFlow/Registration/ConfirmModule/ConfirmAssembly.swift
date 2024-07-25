//
//  ConfirmAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit

final class ConfirmAssembly {
    
    /// DI
    private var networkService: NetworkAuthServiceProtocol
    private var keychainBearerManager: KeychainBearerProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
    }
    
    func assemble(bearer: String) -> ConfirmViewController {
        let viewController = ConfirmViewController()
        let presenter = ConfirmPresenter(view: viewController, networkService: networkService, keychainBearerManager: keychainBearerManager, coordinator: coordinator)
        viewController.presenter = presenter
        
        return viewController
    }
    
}
