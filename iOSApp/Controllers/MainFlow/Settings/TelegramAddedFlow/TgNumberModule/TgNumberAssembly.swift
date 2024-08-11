//
//  TgNumberAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit
import NetworkAPI

final class TgNumberAssembly {
    
    /// DI
    private let networkSevice: NetworkMainProtocol
    
    /// coordinator
    weak var telegramAddCoordinatorProtocol: TelegramAddCoordinatorProtocol?
    
    init(networkSevice: NetworkMainProtocol) {
        self.networkSevice = networkSevice
    }
    
    func assemble() -> TgNumberViewController {
        let viewController = TgNumberViewController()
        let presenter = TgNumberPresenter(view: viewController, networkSevice: networkSevice, telegramAddCoordinatorProtocol: telegramAddCoordinatorProtocol)
        viewController.presenter = presenter
        
        return viewController
    }
    
}
