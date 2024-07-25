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
    
    init(stringsValidation: StringsValidationProtocol, networkService: NetworkRegisterProtocol, passwordAssembly: PasswordAssembly) {
        self.stringsValidation = stringsValidation
        self.networkService = networkService
        self.passwordAssembly = passwordAssembly
    }
    
    func assemble() -> EmailViewController {
        let router = EmailRouter(passwordAssembly: passwordAssembly)
        let viewController = EmailViewController()
        let presenter = EmailPresenter(view: viewController, router: router, networkService: networkService, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
