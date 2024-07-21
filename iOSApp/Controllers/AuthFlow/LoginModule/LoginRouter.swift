//
//  LoginRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit

protocol LoginRouterInput {
    func pushEmailViewController()
    
    func presentEmailRecViewController(email: String?)
}

final class LoginRouter: LoginRouterInput {
    
    weak var viewController: LoginViewController?
    private let emailAssembly: EmailAssembly
    private let emailRecAssembly: EmailRecAssembly
    
    init(emailAssembly: EmailAssembly, emailRecAssembly: EmailRecAssembly) {
        self.emailAssembly = emailAssembly
        self.emailRecAssembly = emailRecAssembly
        
    }
    
    func pushEmailViewController() {
        let view = emailAssembly.assemble()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentEmailRecViewController(email: String?) {
        let view = emailRecAssembly.assemble(email: email)
        let navc = UINavigationController(rootViewController: view)
        navc.isModalInPresentation = true
        viewController?.present(navc, animated: true)
    }
    
    
}
