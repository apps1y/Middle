//
//  ConfirmRecRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.07.2024
//

import UIKit

protocol ConfirmRecRouterInput {
    func pushNewPasswordView(bearer: String)
}

final class ConfirmRecRouter: ConfirmRecRouterInput {
    weak var viewController: ConfirmRecViewController?
    
    private var newPasswordRecAssembly: NewPasswordRecAssembly
    
    init(newPasswordRecAssembly: NewPasswordRecAssembly) {
        self.newPasswordRecAssembly = newPasswordRecAssembly
    }
    
    func pushNewPasswordView(bearer: String) {
        let view = newPasswordRecAssembly.assemble(bearer: bearer)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
