//
//  EmailRecRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol EmailRecRouterInput {
    
}

final class EmailRecRouter: EmailRecRouterInput {
    
    weak var viewController: EmailRecViewController?
    private let passwordRecAssembly: PasswordRecAssembly
    
    init(passwordRecAssembly: PasswordRecAssembly) {
        self.passwordRecAssembly = passwordRecAssembly
    }
}
