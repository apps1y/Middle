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
    private let coreDataService: CoreDataProtocol
    
    init(networkService: NetworkProfileProtocol, coreDataService: CoreDataProtocol) {
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
    
    func assemble() -> HomeViewController {
        let router = HomeRouter()
        let viewController = HomeViewController()
        let presenter = HomePresenter(view: viewController, router: router, networkService: networkService, coreDataService: coreDataService)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
