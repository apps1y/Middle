//
//  EmailAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

final class EmailAssembly {
    
    /// DI
    private let networkService: NetworkAuthServiceProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly's
    private let confirmAssembly: ConfirmAssembly
    
    init(networkService: NetworkAuthServiceProtocol, stringsValidation: StringsValidationProtocol, confirmAssembly: ConfirmAssembly) {
        self.networkService = networkService
        self.stringsValidation = stringsValidation
        self.confirmAssembly = confirmAssembly
    }
    
    func assemble() -> EmailViewController {
        let router = EmailRouter(confirmAssembly: confirmAssembly)
        let viewController = EmailViewController()
        let presenter = EmailPresenter(view: viewController, router: router, networkService: networkService, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
