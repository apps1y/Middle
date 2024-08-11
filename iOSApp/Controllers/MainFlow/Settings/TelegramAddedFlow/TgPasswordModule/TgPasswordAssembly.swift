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
    private let networkSevice: NetworkMainProtocol
    
    /// coordinator
    weak var telegramAddCoordinatorProtocol: TelegramAddCoordinatorProtocol?
    
    init(networkSevice: NetworkMainProtocol) {
        self.networkSevice = networkSevice
    }
    
    func assemble() -> TgPasswordViewController {
        let viewController = TgPasswordViewController()
        let presenter = TgPasswordPresenter(view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
    
}
