//
//  LoginAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit

final class LoginAssembly {
    
    /// DI
    private let networkService: NetworkAuthServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly модули других классов
    private let emailAssembly: EmailAssembly
    private let emailRecAssembly: EmailRecAssembly
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, emailAssembly: EmailAssembly, emailRecAssembly: EmailRecAssembly) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.emailAssembly = emailAssembly
        self.emailRecAssembly = emailRecAssembly
    }
    
    func assemble() -> LoginViewController {
        let router = LoginRouter(emailAssembly: emailAssembly, emailRecAssembly: emailRecAssembly)
        let viewController = LoginViewController()
        let presenter = LoginPresenter(view: viewController, router: router, 
                                       networkService: networkService, 
                                       keychainBearerManager: keychainBearerManager,
                                       stringsValidation: stringsValidation, 
                                       coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
