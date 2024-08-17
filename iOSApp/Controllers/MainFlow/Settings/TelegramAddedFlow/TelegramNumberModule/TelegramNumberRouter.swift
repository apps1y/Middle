//
//  TelegramNumberRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit

protocol TelegramNumberRouterInput {
    func pushTelegramCodeViewCotroller(phoneNumber: String)
    
    /// предупреждение
    func presentWarningAlert(message: String)
}

final class TelegramNumberRouter: TelegramNumberRouterInput {
    weak var viewController: TelegramNumberViewController?
    
    private var telegramCodeAssembly: TelegramCodeAssembly
    private let completion: (TelegramAccountModel) -> Void
    
    private let alertFabric: AlertFabric
    
    init(telegramCodeAssembly: TelegramCodeAssembly, completion: @escaping (TelegramAccountModel) -> Void, alertFabric: AlertFabric) {
        self.telegramCodeAssembly = telegramCodeAssembly
        self.completion = completion
        self.alertFabric = alertFabric
    }
    
    func pushTelegramCodeViewCotroller(phoneNumber: String) {
        let view = telegramCodeAssembly.assemble(phoneNumber: phoneNumber, completion: completion)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
