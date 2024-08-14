//
//  SettingsRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol SettingsRouterInput {
    func presentTelegramAddFlow()
    
    func pushChangePasswordView(email: String)
    
    func presentLogoutAppAlert(completion: @escaping () -> Void)
    
    func presentChangePasswordAlert(completion: @escaping () -> Void)
    
    func presentLogoutTgSheet(completion: @escaping () -> Void)
    
    func presentWarningAlert(message: String)
}

final class SettingsRouter: SettingsRouterInput {
    
    weak var viewController: SettingsViewController?
    
    private var telegramNumberAssembly: TelegramNumberAssembly
    private var confirmRecAssembly: ConfirmRecAssembly
    
    private let alertFabric: AlertFabric
    
    init(telegramNumberAssembly: TelegramNumberAssembly, confirmRecAssembly: ConfirmRecAssembly, alertFabric: AlertFabric) {
        self.telegramNumberAssembly = telegramNumberAssembly
        self.confirmRecAssembly = confirmRecAssembly
        self.alertFabric = alertFabric
    }
    
    func presentTelegramAddFlow() {
        let view = telegramNumberAssembly.assemble()
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
    
    func pushChangePasswordView(email: String) {
        let view = confirmRecAssembly.assemble(email: email)
        view.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentLogoutAppAlert(completion: @escaping () -> Void) {
        let title = "Выйти"
        let message = "Все подключенные telegram аккаунты останутся. В любой момент вы можете зайти, используя почту и пароль."
        let alert = alertFabric.confirmAlert(title: title, message: message, actionTitle: "Выйти", handler: completion)
        viewController?.present(alert, animated: true)
    }
    
    func presentChangePasswordAlert(completion: @escaping () -> Void) {
        let title = "Изменить пароль"
        let message = "После смены пароля потребуется повторный вход в аккаунт на всех других устройствах."
        let alert = alertFabric.confirmAlert(title: title, message: message, actionTitle: "Изменить", handler: completion)
        viewController?.present(alert, animated: true)
    }
    
    func presentLogoutTgSheet(completion: @escaping () -> Void) {
        let message = "Сессия на выбранном аккаунте завершится. Активные сессии вы можете найти в telegram, в разделе устройства."
        let actionSheet = alertFabric.confirmActionSheet(message: message, actionTitle: "Отвязать", handler: completion)
        viewController?.present(actionSheet, animated: true)
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
