//
//  TgPasswordAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit
import NetworkAPI

final class TgPasswordAssembly {
    
    /// DI
    private let networkSevice: NetworkProfileProtocol
    
    /// coordinator
    weak var telegramAddCoordinator: TelegramAddCoordinatorProtocol?
    
    init(networkSevice: NetworkProfileProtocol) {
        self.networkSevice = networkSevice
    }
    
    func assemble() -> TgPasswordViewController {
        let viewController = TgPasswordViewController()
        let presenter = TgPasswordPresenter(view: viewController, telegramAddCoordinator: telegramAddCoordinator)
        viewController.presenter = presenter
        
        return viewController
    }
    
}
