//
//  SettingsRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol SettingsRouterInput {
    func presentTelegramAddFlow(completion: @escaping (TelegramAccountModel) -> Void)
    
    func pushRepasswordPreview(email: String)
    
    func presentLogoutAppAlert(completion: @escaping () -> Void)
    
    func presentLogoutTgSheet(completion: @escaping () -> Void)
    
    func presentWarningAlert(message: String)
}

final class SettingsRouter: SettingsRouterInput {
    
    weak var viewController: SettingsViewController?
    
    private var telegramNumberAssembly: TelegramNumberAssembly
    private let repasswordPreviewAssembly: RepasswordPreviewAssembly
    
    private let alertFabric: AlertFabric
    
    init(telegramNumberAssembly: TelegramNumberAssembly, repasswordPreviewAssembly: RepasswordPreviewAssembly, alertFabric: AlertFabric) {
        self.telegramNumberAssembly = telegramNumberAssembly
        self.repasswordPreviewAssembly = repasswordPreviewAssembly
        self.alertFabric = alertFabric
    }
    
    func presentTelegramAddFlow(completion: @escaping (TelegramAccountModel) -> Void) {
        let view = telegramNumberAssembly.assemble()
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
    
    func pushRepasswordPreview(email: String) {
        let view = repasswordPreviewAssembly.assemble(userEmail: email)
        view.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentLogoutAppAlert(completion: @escaping () -> Void) {
        let title = "Выйти"
        let message = "Все подключенные telegram аккаунты останутся. В любой момент вы можете зайти, используя почту и пароль."
        let alert = alertFabric.confirmAlert(title: title, message: message, actionTitle: "Выйти", handler: completion)
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
