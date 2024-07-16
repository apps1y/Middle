//
//  EmailAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

final class EmailAssembly {
    
    private let networkService: NetworkAuthServiceProtocol
    private let authManager: AuthManager
    private let stringsValidation: StringsValidationProtocol
    
    init(networkService: NetworkAuthServiceProtocol, authManager: AuthManager, stringsValidation: StringsValidationProtocol) {
        self.networkService = networkService
        self.authManager = authManager
        self.stringsValidation = stringsValidation
    }
    
    func assemble() -> EmailViewController {
        let router = EmailRouter()
        let viewController = EmailViewController()
        let presenter = EmailPresenter(view: viewController, router: router, networkService: networkService, authManager: authManager, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
