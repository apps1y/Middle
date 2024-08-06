//
//  ConfirmRouter.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 28.07.2024.
//

import UIKit

protocol ConfirmRouterInput {
    func presentWarningAlert(message: String)
}

final class ConfirmRouter: ConfirmRouterInput {
    weak var viewController: ConfirmViewController?
    
    private let alertFabric: AlertFabric
    
    init(alertFabric: AlertFabric) {
        self.alertFabric = alertFabric
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAuthAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
