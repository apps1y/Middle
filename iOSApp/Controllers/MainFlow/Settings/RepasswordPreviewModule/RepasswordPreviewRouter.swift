//
//  RepasswordPreviewRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.08.2024
//

import UIKit

protocol RepasswordPreviewRouterInput {
    
    /// показ предупреждения об ошибке
    /// - Parameter message: текст предупреждения
    func presentWarningAlert(message: String)
    
    /// открытие экрана подтверждения
    /// - Parameter userEmail: почта юзера
    func pushConfirmCodeController(userEmail: String)
}

final class RepasswordPreviewRouter: RepasswordPreviewRouterInput {
    
    weak var viewController: RepasswordPreviewViewController?
    
    private let alertFabric: AlertFabric
    private let confirmRecAssembly: ConfirmRecAssembly
    
    init(alertFabric: AlertFabric, confirmRecAssembly: ConfirmRecAssembly) {
        self.alertFabric = alertFabric
        self.confirmRecAssembly = confirmRecAssembly
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAlert(message: message)
        viewController?.present(alert, animated: true)
    }
    
    func pushConfirmCodeController(userEmail: String) {
        let view = confirmRecAssembly.assemble(email: userEmail)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
