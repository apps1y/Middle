//
//  ConfirmRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit

protocol ConfirmRouterInput {
    func pushPasswordModule()
}

final class ConfirmRouter: ConfirmRouterInput {
    weak var viewController: ConfirmViewController?
    
    private var passwordAssembly: PasswordAssembly
    
    init(viewController: ConfirmViewController? = nil, passwordAssembly: PasswordAssembly) {
        self.viewController = viewController
        self.passwordAssembly = passwordAssembly
    }
    
    func pushPasswordModule() {
        let view = passwordAssembly.assemble()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
