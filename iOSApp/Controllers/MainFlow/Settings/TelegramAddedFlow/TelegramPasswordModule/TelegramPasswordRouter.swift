//
//  TelegramPasswordRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit

protocol TelegramPasswordRouterInput {
    
    /// на экран назад и заново код
    func warningIncorrectOneTimeCode()
    
    /// заново пароль
    func warningIncorrectPassword()
    
    /// неизвестная ошибка и dssmiss
    func warningAuknownError()
    
    /// завершение flow с вызовом completion
    func dismissViewWithCompletion(account: TelegramAccountModel)
    
    /// предупреждение
    func presentWarningAlert(message: String)
}

final class TelegramPasswordRouter: TelegramPasswordRouterInput {
    weak var viewController: TelegramPasswordViewController?
    
    private let alertFabric: AlertFabric
    private let completion: (TelegramAccountModel) -> Void
    
    init(alertFabric: AlertFabric, completion: @escaping (TelegramAccountModel) -> Void) {
        self.alertFabric = alertFabric
        self.completion = completion
    }
    
    func warningIncorrectPassword() {
        let alert = alertFabric.warningAlertWithAction(title: "Неверный пароль",
                                                       message: "Попробуйте ввести другой пароль.") {}
        viewController?.present(alert, animated: true)
    }
    
    func warningIncorrectOneTimeCode() {
        let alert = alertFabric.warningAlertWithAction(title: "Неверный код",
                                                       message: "Попробуйте ввести код еще раз.") { [weak self] in
            self?.viewController?.navigationController?.popViewController(animated: true)
        }
        viewController?.present(alert, animated: true)
    }
    
    func warningAuknownError() {
        let alert = alertFabric.warningAlertWithAction(title: "Неизвестная ошибка",
                                                       message: "Начните добавление аккаунта заново.") { [weak self] in
            self?.viewController?.navigationController?.dismiss(animated: true)
        }
        viewController?.present(alert, animated: true)
    }
    
    func dismissViewWithCompletion(account: TelegramAccountModel) {
        completion(account)
        viewController?.navigationController?.dismiss(animated: true)
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
