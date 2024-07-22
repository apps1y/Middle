//
//  PasswordAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

final class PasswordAssembly {
    
    /// DI
    private let networkService: NetworkAuthServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
    }
    
    func assemble() -> PasswordViewController {
        let router = PasswordRouter()
        let viewController = PasswordViewController()
        let presenter = PasswordPresenter(view: viewController, router: router,
                                          networkService: networkService,
                                          keychainBearerManager: keychainBearerManager,
                                          stringsValidation: stringsValidation, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
