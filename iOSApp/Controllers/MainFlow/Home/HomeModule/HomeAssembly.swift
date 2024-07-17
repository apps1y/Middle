//
//  HomeAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

final class HomeAssembly {
    
    private let networkService: NetworkMainServiceProtocol
    private let databasePreviewsManager: DatabasePreviewsProtocol
    
    init(networkService: NetworkMainServiceProtocol, databasePreviewsManager: DatabasePreviewsProtocol) {
        self.networkService = networkService
        self.databasePreviewsManager = databasePreviewsManager
    }
    
    func assemble() -> HomeViewController {
        let router = HomeRouter()
        let viewController = HomeViewController()
        let presenter = HomePresenter(view: viewController, router: router, networkService: networkService, databasePreviewsManager: databasePreviewsManager)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
