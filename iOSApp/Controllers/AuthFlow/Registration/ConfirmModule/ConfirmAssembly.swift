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
    private var networkService: NetworkConfirmProtocol
    private var keychainBearerManager: KeychainBearerProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(networkService: NetworkConfirmProtocol, keychainBearerManager: KeychainBearerProtocol) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
    }
    
    func assemble(token: String) -> ConfirmViewController {
        let viewController = ConfirmViewController()
        let presenter = ConfirmPresenter(view: viewController, networkService: networkService, keychainBearerManager: keychainBearerManager, coordinator: coordinator, token: token)
        viewController.presenter = presenter
        
        return viewController
    }
    
}
