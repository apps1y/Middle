//
//  EmailRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

protocol EmailRouterInput {
    
    /// открытие экрана подверждения почты
    func pushPasswordView(email: String)
}

final class EmailRouter: EmailRouterInput {
    
    weak var viewController: EmailViewController?
    
    private let passwordAssembly: PasswordAssembly
    
    init(passwordAssembly: PasswordAssembly) {
        self.passwordAssembly = passwordAssembly
    }
    
    func pushPasswordView(email: String) {
        let view = passwordAssembly.assemble(email: email)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
