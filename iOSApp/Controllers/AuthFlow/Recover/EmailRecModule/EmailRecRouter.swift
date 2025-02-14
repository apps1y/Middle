//
//  EmailRecRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol EmailRecRouterInput {
    func pushConfirmView(email: String)
    
    func presentWarningAlert(message: String)
}

final class EmailRecRouter: EmailRecRouterInput {
    
    weak var viewController: EmailRecViewController?
    private let confirmRecAssembly: ConfirmRecAssembly
    
    /// Fabrics
    private let alertFabric: AlertFabric
    
    init(confirmRecAssembly: ConfirmRecAssembly, alertFabric: AlertFabric) {
        self.confirmRecAssembly = confirmRecAssembly
        self.alertFabric = alertFabric
    }
    
    func pushConfirmView(email: String) {
        let view = confirmRecAssembly.assemble(email: email)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
