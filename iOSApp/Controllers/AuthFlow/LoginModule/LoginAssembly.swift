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
    private let networkService: NetworkAuthProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly модули других классов
    private let emailAssembly: EmailAssembly
    private let emailRecAssembly: EmailRecAssembly
    private let confirmAssembly: ConfirmAssembly
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    /// Fabrics
    private let alertFabric: AlertFabric
    
    init(networkService: NetworkAuthProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, emailAssembly: EmailAssembly, emailRecAssembly: EmailRecAssembly, confirmAssembly: ConfirmAssembly, coordinator: FlowCoordinator? = nil, alertFabric: AlertFabric) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.emailAssembly = emailAssembly
        self.emailRecAssembly = emailRecAssembly
        self.confirmAssembly = confirmAssembly
        self.coordinator = coordinator
        self.alertFabric = alertFabric
    }
    
    func assemble() -> LoginViewController {
        let router = LoginRouter(emailAssembly: emailAssembly, emailRecAssembly: emailRecAssembly, confirmAssembly: confirmAssembly, alertFabric: alertFabric)
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
