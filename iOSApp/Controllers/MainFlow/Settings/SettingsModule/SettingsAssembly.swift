//
//  SettingsAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

final class SettingsAssembly {
    
    private let networkService: NetworkMainServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    
    init(networkService: NetworkMainServiceProtocol, keychainBearerManager: KeychainBearerProtocol) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
    }
    
    func assemble(completion: @escaping () -> Void) -> SettingsViewController {
        let router = SettingsRouter()
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, completion: completion)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
