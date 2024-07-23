//
//  EmailAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

final class EmailAssembly {
    
    /// DI
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly's
    private let passwordAssembly: PasswordAssembly
    
    init(stringsValidation: StringsValidationProtocol, 
         passwordAssembly: PasswordAssembly) {
        self.stringsValidation = stringsValidation
        self.passwordAssembly = passwordAssembly
    }
    
    func assemble() -> EmailViewController {
        let router = EmailRouter(passwordAssembly: passwordAssembly)
        let viewController = EmailViewController()
        let presenter = EmailPresenter(view: viewController, router: router, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
