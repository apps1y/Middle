//
//  EmailRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

protocol EmailRouterInput {
    
}

final class EmailRouter: EmailRouterInput {
    
    weak var viewController: EmailViewController?
    private let passwordRouter: PasswordAssembly
    
    init(passwordRouter: PasswordAssembly) {
        self.passwordRouter = passwordRouter
    }
}
