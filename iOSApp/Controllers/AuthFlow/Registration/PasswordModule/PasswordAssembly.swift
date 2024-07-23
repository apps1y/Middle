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
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly's
    private let confirmAssembly: ConfirmAssembly
    
    init(networkService: NetworkAuthServiceProtocol, stringsValidation: StringsValidationProtocol, confirmAssembly: ConfirmAssembly) {
        self.networkService = networkService
        self.stringsValidation = stringsValidation
        self.confirmAssembly = confirmAssembly
    }
    
    func assemble(email: String) -> PasswordViewController {
        let router = PasswordRouter(confirmAssembly: confirmAssembly)
        let viewController = PasswordViewController()
        let presenter = PasswordPresenter(view: viewController, router: router,
                                          networkService: networkService,
                                          stringsValidation: stringsValidation, email: email)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
