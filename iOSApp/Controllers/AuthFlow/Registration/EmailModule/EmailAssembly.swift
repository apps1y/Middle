//
//  EmailAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

final class EmailAssembly {
    
    /// DI
    private let networkService: NetworkAuthServiceProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly's
    private let passwordAssembly: PasswordAssembly
    
    init(networkService: NetworkAuthServiceProtocol, stringsValidation: StringsValidationProtocol, passwordAssembly: PasswordAssembly) {
        self.networkService = networkService
        self.stringsValidation = stringsValidation
        self.passwordAssembly = passwordAssembly
    }
    
    func assemble() -> EmailViewController {
        let router = EmailRouter(passwordRouter: passwordAssembly)
        let viewController = EmailViewController()
        let presenter = EmailPresenter(view: viewController, router: router, networkService: networkService, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
