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
    private let networkSevice: NetworkProfileProtocol
    private let alertFabric: AlertFabric
    
    /// coordinator
    weak var telegramAddCoordinator: TelegramAddCoordinatorProtocol?
    
    init(networkSevice: NetworkProfileProtocol, alertFabric: AlertFabric) {
        self.networkSevice = networkSevice
        self.alertFabric = alertFabric
    }
    
    func assemble() -> TgNumberViewController {
        let viewController = TgNumberViewController()
        let presenter = TgNumberPresenter(view: viewController, networkSevice: networkSevice, alertFabric: alertFabric, telegramAddCoordinator: telegramAddCoordinator)
        viewController.presenter = presenter
        return viewController
    }
    
}
