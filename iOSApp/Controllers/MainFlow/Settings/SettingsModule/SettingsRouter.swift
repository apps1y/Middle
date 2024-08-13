//
//  SettingsRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol SettingsRouterInput {
    func presentTelegramAddFlow(successCompletion: @escaping (String) -> Void)
    
    func pushRecoveryFlow(email: String)
}

final class SettingsRouter: SettingsRouterInput {
    weak var viewController: SettingsViewController?
    
    private var telegramAddAssembly: TelegramAddAssembly
    
    private var confirmRecAssembly: ConfirmRecAssembly
    
    init(telegramAddAssembly: TelegramAddAssembly, confirmRecAssembly: ConfirmRecAssembly) {
        self.telegramAddAssembly = telegramAddAssembly
        self.confirmRecAssembly = confirmRecAssembly
    }
    
    func presentTelegramAddFlow(successCompletion: @escaping (String) -> Void) {
        let telegramAddCoordinator = telegramAddAssembly.assemble(successCompletion: successCompletion)
        let navigationController = TelegramNavigationController(coordinator: telegramAddCoordinator)
        telegramAddCoordinator.navigationController = navigationController
        telegramAddCoordinator.start()
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
    
    func pushRecoveryFlow(email: String) {
        let view = confirmRecAssembly.assemble(email: email)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
