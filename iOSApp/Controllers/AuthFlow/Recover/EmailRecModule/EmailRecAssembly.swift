//
//  EmailRecAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

final class EmailRecAssembly {
    
    /// DI
    private let networkService: NetworkAuthServiceProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly's
    private let passwordRecAssembly: PasswordRecAssembly
    
    init(networkService: NetworkAuthServiceProtocol, stringsValidation: StringsValidationProtocol, passwordRecAssembly: PasswordRecAssembly) {
        self.networkService = networkService
        self.stringsValidation = stringsValidation
        self.passwordRecAssembly = passwordRecAssembly
    }
    
    func assemble() -> EmailRecViewController {
        let router = EmailRecRouter(passwordRecAssembly: passwordRecAssembly)
        let viewController = EmailRecViewController()
        let presenter = EmailRecPresenter(view: viewController, router: router, networkService: networkService, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
