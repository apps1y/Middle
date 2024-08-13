//
//  TgOneTimeCodeAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit
import NetworkAPI

final class TgOneTimeCodeAssembly {
    
    /// DI
    private let networkSevice: NetworkProfileProtocol
    
    /// coordinator
    weak var telegramAddCoordinator: TelegramAddCoordinatorProtocol?
    
    init(networkSevice: NetworkProfileProtocol) {
        self.networkSevice = networkSevice
    }
    
    func assemble() -> TgOneTimeCodeViewController {
        let viewController = TgOneTimeCodeViewController(number: "+7 905 717-77-60")
        let presenter = TgOneTimeCodePresenter(view: viewController, telegramAddCoordinator: telegramAddCoordinator)
        viewController.presenter = presenter
        
        return viewController
    }
    
}
