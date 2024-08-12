//
//  SettingsRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol SettingsRouterInput {
    func presentTelegramAddFlow()
}

final class SettingsRouter: SettingsRouterInput {
    weak var viewController: SettingsViewController?
    
    private var telegramAddAssembly: TelegramAddAssembly
    
    init(telegramAddAssembly: TelegramAddAssembly) {
        self.telegramAddAssembly = telegramAddAssembly
    }
    
    func presentTelegramAddFlow() {
        let telegramAddCoordinator = telegramAddAssembly.assemble()
        let navigationController = TelegramNavigationController(coordinator: telegramAddCoordinator)
        telegramAddCoordinator.navigationController = navigationController
        telegramAddCoordinator.start()
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
}
