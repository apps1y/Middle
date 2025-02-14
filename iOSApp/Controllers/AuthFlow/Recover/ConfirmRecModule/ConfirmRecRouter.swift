//
//  ConfirmRecRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.07.2024
//

import UIKit

protocol ConfirmRecRouterInput {
    func pushNewPasswordView(bearer: String)
    
    func presentWarningAlert(message: String)
}

final class ConfirmRecRouter: ConfirmRecRouterInput {
    
    weak var viewController: ConfirmRecViewController?
    private var newPasswordRecAssembly: NewPasswordRecAssembly
    
    /// Fabrics
    private let alertFabric: AlertFabric
    
    init(newPasswordRecAssembly: NewPasswordRecAssembly, alertFabric: AlertFabric) {
        self.newPasswordRecAssembly = newPasswordRecAssembly
        self.alertFabric = alertFabric
    }
    
    func pushNewPasswordView(bearer: String) {
        let view = newPasswordRecAssembly.assemble(bearer: bearer)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
