//
//  PasswordRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

protocol PasswordRouterInput {
    func pushConfirmView(bearer: String)
    
    /// предупреждение
    func presentWarningAlert(message: String)
}

final class PasswordRouter: PasswordRouterInput {
    weak var viewController: PasswordViewController?
    
    private let confirmAssembly: ConfirmAssembly
    
    /// Fabrics
    private let alertFabric: AlertFabricProtocol
    
    init(confirmAssembly: ConfirmAssembly, alertFabric: AlertFabricProtocol) {
        self.confirmAssembly = confirmAssembly
        self.alertFabric = alertFabric
    }
    
    func pushConfirmView(bearer: String) {
        let view = confirmAssembly.assemble(token: bearer)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAuthAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
