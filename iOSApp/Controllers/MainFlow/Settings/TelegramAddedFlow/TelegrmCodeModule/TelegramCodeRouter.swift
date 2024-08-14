//
//  TelegramCodeRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit

protocol TelegramCodeRouterInput {
    func pushPasswordViewController(number: String, oneTimeCode: String)
}

final class TelegramCodeRouter: TelegramCodeRouterInput {
    weak var viewController: TelegramCodeViewController?
    
    private let telegramPasswordAssembly: TelegramPasswordAssembly
    
    init(telegramPasswordAssembly: TelegramPasswordAssembly) {
        self.telegramPasswordAssembly = telegramPasswordAssembly
    }
    
    func pushPasswordViewController(number: String, oneTimeCode: String) {
        let view = telegramPasswordAssembly.assemble(phoneNumber: number, oneTimeCode: oneTimeCode)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
