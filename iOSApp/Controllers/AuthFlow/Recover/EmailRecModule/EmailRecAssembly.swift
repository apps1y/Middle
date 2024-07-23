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
    private let confirmRecAssembly: ConfirmRecAssembly
    
    init(networkService: NetworkAuthServiceProtocol, stringsValidation: StringsValidationProtocol, confirmRecAssembly: ConfirmRecAssembly) {
        self.networkService = networkService
        self.stringsValidation = stringsValidation
        self.confirmRecAssembly = confirmRecAssembly
    }
    
    func assemble(email: String?) -> EmailRecViewController {
        let router = EmailRecRouter(confirmRecAssembly: confirmRecAssembly)
        let viewController = EmailRecViewController(email: email)
        let presenter = EmailRecPresenter(view: viewController, router: router, networkService: networkService, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
