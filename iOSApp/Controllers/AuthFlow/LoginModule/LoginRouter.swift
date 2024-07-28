//
//  LoginRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit

protocol LoginRouterInput {
    /// открытие экрана регистрации
    func pushEmailViewController()
    
    /// открытие экрана восстановления
    /// - Parameters:
    ///   - email: почта, которая уже будет вбита в открывшемся экране
    func presentEmailRecViewController(email: String?)
    
    /// открытие экрана подтверждения
    func pushConfirmViewController(token: String)
    
    /// предупреждение
    func presentWarningAlert(message: String)
}

final class LoginRouter: LoginRouterInput {
    
    weak var viewController: LoginViewController?
    
    private let emailAssembly: EmailAssembly
    private let emailRecAssembly: EmailRecAssembly
    private let confirmAssembly: ConfirmAssembly
    
    /// Fabrics
    private let alertFabric: AlertFabricProtocol
    
    init(emailAssembly: EmailAssembly, emailRecAssembly: EmailRecAssembly, confirmAssembly: ConfirmAssembly, alertFabric: AlertFabricProtocol) {
        self.emailAssembly = emailAssembly
        self.emailRecAssembly = emailRecAssembly
        self.confirmAssembly = confirmAssembly
        self.alertFabric = alertFabric
    }
    
    func pushEmailViewController() {
        let view = emailAssembly.assemble()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentEmailRecViewController(email: String?) {
        let view = emailRecAssembly.assemble(email: email)
        let navc = UINavigationController(rootViewController: view)
        navc.modalPresentationStyle = .fullScreen
        viewController?.present(navc, animated: true)
    }
    
    func pushConfirmViewController(token: String) {
        let view = confirmAssembly.assemble(token: token)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAuthAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
