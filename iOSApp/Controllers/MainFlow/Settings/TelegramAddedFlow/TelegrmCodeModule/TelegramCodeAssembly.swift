//
//  TelegramCodeAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit

final class TelegramCodeAssembly {
    
    private let telegramPasswordAssembly: TelegramPasswordAssembly
    
    init(telegramPasswordAssembly: TelegramPasswordAssembly) {
        self.telegramPasswordAssembly = telegramPasswordAssembly
    }
    
    func assemble(phoneNumber: String) -> TelegramCodeViewController {
        let router = TelegramCodeRouter(telegramPasswordAssembly: telegramPasswordAssembly)
        let viewController = TelegramCodeViewController()
        let presenter = TelegramCodePresenter(view: viewController, router: router, phoneNumber: phoneNumber)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
