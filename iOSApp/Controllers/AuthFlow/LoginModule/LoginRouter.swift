//
//  LoginRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit

protocol LoginRouterInput {
    
}

final class LoginRouter: LoginRouterInput {
    
    weak var viewController: LoginViewController?
    private let emailAssembly: EmailAssembly
    private let emailRecAssembly: EmailRecAssembly
    
    init(emailAssembly: EmailAssembly, emailRecAssembly: EmailRecAssembly) {
        self.emailAssembly = emailAssembly
        self.emailRecAssembly = emailRecAssembly
    }
}
