//
//  EmailAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit
import NetworkAPI

final class EmailAssembly {
    
    /// DI
    private let stringsValidation: StringsValidationProtocol
    private let networkService: NetworkRegisterProtocol
    
    /// Assembly's
    private let passwordAssembly: PasswordAssembly
    
    /// Fabrics
    private let alertFabric: AlertFabricProtocol
    
    init(stringsValidation: StringsValidationProtocol, networkService: NetworkRegisterProtocol, passwordAssembly: PasswordAssembly, alertFabric: AlertFabricProtocol) {
        self.stringsValidation = stringsValidation
        self.networkService = networkService
        self.passwordAssembly = passwordAssembly
        self.alertFabric = alertFabric
    }
    
    func assemble() -> EmailViewController {
        let router = EmailRouter(passwordAssembly: passwordAssembly, alertFabric: alertFabric)
        let viewController = EmailViewController()
        let presenter = EmailPresenter(view: viewController, router: router, networkService: networkService, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
