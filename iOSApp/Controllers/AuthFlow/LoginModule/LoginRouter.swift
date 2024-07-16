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
    
    init(emailAssembly: EmailAssembly) {
        self.emailAssembly = emailAssembly
    }
}
