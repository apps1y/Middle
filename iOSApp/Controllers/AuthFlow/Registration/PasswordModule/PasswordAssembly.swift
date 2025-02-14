//
//  PasswordAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit
import NetworkAPI

final class PasswordAssembly {
    
    /// DI
    private let networkService: NetworkAuthProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly's
    private let confirmAssembly: ConfirmAssembly
    private let alertFabric: AlertFabric
    
    init(networkService: NetworkAuthProtocol, stringsValidation: StringsValidationProtocol, confirmAssembly: ConfirmAssembly, alertFabric: AlertFabric) {
        self.networkService = networkService
        self.stringsValidation = stringsValidation
        self.confirmAssembly = confirmAssembly
        self.alertFabric = alertFabric
    }
    
    func assemble(email: String) -> PasswordViewController {
        let router = PasswordRouter(confirmAssembly: confirmAssembly, alertFabric: alertFabric)
        let viewController = PasswordViewController()
        let presenter = PasswordPresenter(view: viewController, router: router,
                                          networkService: networkService,
                                          stringsValidation: stringsValidation, email: email)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
