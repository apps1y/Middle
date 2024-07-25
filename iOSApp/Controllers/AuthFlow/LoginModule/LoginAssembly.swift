//
//  LoginAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit
import NetworkAPI

final class LoginAssembly {
    
    /// DI
    private let networkService: NetworkLoginProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly модули других классов
    private let emailAssembly: EmailAssembly
    private let emailRecAssembly: EmailRecAssembly
    private let confirmAssembly: ConfirmAssembly
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(networkService: NetworkLoginProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, emailAssembly: EmailAssembly, emailRecAssembly: EmailRecAssembly, confirmAssembly: ConfirmAssembly) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.emailAssembly = emailAssembly
        self.emailRecAssembly = emailRecAssembly
        self.confirmAssembly = confirmAssembly
    }
    
    func assemble() -> LoginViewController {
        let router = LoginRouter(emailAssembly: emailAssembly, emailRecAssembly: emailRecAssembly, confirmAssembly: confirmAssembly)
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
