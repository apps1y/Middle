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
        let navigationViewController = UINavigationController()
        let telegramAddCoordinator = telegramAddAssembly.assemble(navigationController: navigationViewController)
        telegramAddCoordinator.start()
        navigationViewController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationViewController, animated: true)
    }
}
