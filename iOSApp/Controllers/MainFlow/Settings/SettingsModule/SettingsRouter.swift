//
//  SettingsRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol SettingsRouterInput {
    /// открытие начального экрана смены пароля
    /// - Parameter email: почта юзера
    func pushRepasswordPreview(email: String)
    
    /// показ предупреждения при выходе из приложения
    /// - Parameter completion: действия при согласии
    func presentLogoutAppAlert(completion: @escaping () -> Void)
    
    /// показ предупреждения об ошибке
    /// - Parameter message: текст предупреждения
    func presentWarningAlert(message: String)
}

final class SettingsRouter: SettingsRouterInput {
    
    weak var viewController: SettingsViewController?
    
    private let repasswordPreviewAssembly: RepasswordPreviewAssembly
    
    private let alertFabric: AlertFabric
    
    init(repasswordPreviewAssembly: RepasswordPreviewAssembly, alertFabric: AlertFabric) {
        self.repasswordPreviewAssembly = repasswordPreviewAssembly
        self.alertFabric = alertFabric
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
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
