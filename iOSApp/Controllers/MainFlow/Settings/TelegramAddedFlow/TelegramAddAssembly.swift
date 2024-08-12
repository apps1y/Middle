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
    
    func assemble() -> TelegramAddCoordinator {
        let telegramAddCoordinator = TelegramAddCoordinator(tgNumberAssembly: tgNumberAssembly, tgOneTimeCodeAssembly: tgOneTimeCodeAssembly, tgPasswordAssembly: tgPasswordAssembly)
        
        tgNumberAssembly.telegramAddCoordinator = telegramAddCoordinator
        
        return telegramAddCoordinator
    }
}
