//
//  TelegramAddAssemble.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 10.08.2024.
//

import UIKit

final class TelegramAddAssembly {
    
    private let tgNumberAssembly: TgNumberAssembly
    private let tgOneTimeCodeAssembly: TgOneTimeCodeAssembly
    private let tgPasswordAssembly: TgPasswordAssembly
    
    init(tgNumberAssembly: TgNumberAssembly, tgOneTimeCodeAssembly: TgOneTimeCodeAssembly, tgPasswordAssembly: TgPasswordAssembly) {
        self.tgNumberAssembly = tgNumberAssembly
        self.tgOneTimeCodeAssembly = tgOneTimeCodeAssembly
        self.tgPasswordAssembly = tgPasswordAssembly
    }
    
    func assemble(successCompletion: @escaping (String) -> Void) -> TelegramAddCoordinator {
        let telegramAddCoordinator = TelegramAddCoordinator(tgNumberAssembly: tgNumberAssembly, tgOneTimeCodeAssembly: tgOneTimeCodeAssembly, tgPasswordAssembly: tgPasswordAssembly, successCompletion: successCompletion)
        
        tgNumberAssembly.telegramAddCoordinator = telegramAddCoordinator
        tgOneTimeCodeAssembly.telegramAddCoordinator = telegramAddCoordinator
        tgPasswordAssembly.telegramAddCoordinator = telegramAddCoordinator
        
        return telegramAddCoordinator
    }
}
