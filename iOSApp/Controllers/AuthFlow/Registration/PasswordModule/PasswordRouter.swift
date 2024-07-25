//
//  PasswordRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

protocol PasswordRouterInput {
    func pushConfirmView(bearer: String)
}

final class PasswordRouter: PasswordRouterInput {
    weak var viewController: PasswordViewController?
    
    private let confirmAssembly: ConfirmAssembly
    
    init(confirmAssembly: ConfirmAssembly) {
        self.confirmAssembly = confirmAssembly
    }
    
    func pushConfirmView(bearer: String) {
        let view = confirmAssembly.assemble(token: bearer)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
