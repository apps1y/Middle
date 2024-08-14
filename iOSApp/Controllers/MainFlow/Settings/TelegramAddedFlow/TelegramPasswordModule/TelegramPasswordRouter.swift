//
//  TelegramPasswordRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit

protocol TelegramPasswordRouterInput {
    func warningIncorrectOneTimeCode()
    
    func warningIncorrectPassword()
}

final class TelegramPasswordRouter: TelegramPasswordRouterInput {
    weak var viewController: TelegramPasswordViewController?
    
    private let alertFabric: AlertFabric
    
    init(alertFabric: AlertFabric) {
        self.alertFabric = alertFabric
    }
    
    func warningIncorrectPassword() {
        let alert = alertFabric.warningAlertWithAction(title: "Неверный пароль",
                                                       message: "Попробуйте ввести другой пароль.") {}
    }
    
    func warningIncorrectOneTimeCode() {
        let alert = alertFabric.warningAlertWithAction(title: "Неверный код",
                                                       message: "Попробуйте ввести код еще раз.") { [weak self] in
            self?.viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
