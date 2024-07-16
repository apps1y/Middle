//
//  LoginAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit

final class LoginAssembly {
    
    /// di
    private let networkService: NetworkAuthServiceProtocol
    private let authManager: AuthManager
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly модули других классов
    private let emailAssembly: EmailAssembly
    
    init(networkService: NetworkAuthServiceProtocol, authManager: AuthManager, stringsValidation: StringsValidationProtocol, emailAssembly: EmailAssembly) {
        self.networkService = networkService
        self.authManager = authManager
        self.stringsValidation = stringsValidation
        self.emailAssembly = emailAssembly
    }
    
    func assemble() -> LoginViewController {
        let router = LoginRouter(emailAssembly: emailAssembly)
        let viewController = LoginViewController()
        let presenter = LoginPresenter(view: viewController, router: router, networkService: networkService, authManager: authManager, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
