//
//  NewPasswordRecRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.07.2024
//

import UIKit

protocol NewPasswordRecRouterInput {
    func presentWarningAlert(message: String)
}

final class NewPasswordRecRouter: NewPasswordRecRouterInput {
    weak var viewController: NewPasswordRecViewController?
    
    /// Fabrics
    private let alertFabric: AlertFabric
    
    init(alertFabric: AlertFabric) {
        self.alertFabric = alertFabric
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
