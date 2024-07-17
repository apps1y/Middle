//
//  PasswordRecAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

final class PasswordRecAssembly {
    
    /// DI
    private let networkService: NetworkAuthServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    init(networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
    }
    
    func assemble() -> PasswordRecViewController {
        let router = PasswordRecRouter()
        let viewController = PasswordRecViewController()
        let presenter = PasswordRecPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
