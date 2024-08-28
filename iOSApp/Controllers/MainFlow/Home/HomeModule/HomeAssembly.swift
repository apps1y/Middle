//
//  HomeAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

final class HomeAssembly {
    
    private let networkService: NetworkProfileProtocol
    private let cashingRepisitory: CashingRepositoryProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let alertFabric: AlertFabric
    
    private let unravelAssembly: UnravelAssembly
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(networkService: NetworkProfileProtocol, cashingRepisitory: CashingRepositoryProtocol, keychainBearerManager: KeychainBearerProtocol, alertFabric: AlertFabric, unravelAssembly: UnravelAssembly) {
        self.networkService = networkService
        self.cashingRepisitory = cashingRepisitory
        self.keychainBearerManager = keychainBearerManager
        self.alertFabric = alertFabric
        self.unravelAssembly = unravelAssembly
    }
    
    
    
    func assemble() -> HomeViewController {
        let router = HomeRouter(alertFabric: alertFabric, unravelAssembly: unravelAssembly)
        let viewController = HomeViewController()
        let presenter = HomePresenter(view: viewController, router: router, networkService: networkService,
                                      cashingRepisitory: cashingRepisitory, 
                                      keychainBearerManager: keychainBearerManager, coordinator: coordinator)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
