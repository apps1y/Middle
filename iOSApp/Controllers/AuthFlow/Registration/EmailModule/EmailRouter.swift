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
    
    /// предупреждение
    func presentWarningAlert(message: String)
}

final class EmailRouter: EmailRouterInput {
    
    weak var viewController: EmailViewController?
    
    private let passwordAssembly: PasswordAssembly
    private let alertFabric: AlertFabric
    
    init(passwordAssembly: PasswordAssembly, alertFabric: AlertFabric) {
        self.passwordAssembly = passwordAssembly
        self.alertFabric = alertFabric
    }
    
    func pushPasswordView(email: String) {
        let view = passwordAssembly.assemble(email: email)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAuthAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
