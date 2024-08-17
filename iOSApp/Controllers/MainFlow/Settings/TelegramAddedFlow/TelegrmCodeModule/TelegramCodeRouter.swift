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
    private let completion: (TelegramAccountModel) -> Void
    
    init(telegramPasswordAssembly: TelegramPasswordAssembly, completion: @escaping (TelegramAccountModel) -> Void) {
        self.telegramPasswordAssembly = telegramPasswordAssembly
        self.completion = completion
    }
    
    func pushPasswordViewController(number: String, oneTimeCode: String) {
        let view = telegramPasswordAssembly.assemble(phoneNumber: number, oneTimeCode: oneTimeCode, completion: completion)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
