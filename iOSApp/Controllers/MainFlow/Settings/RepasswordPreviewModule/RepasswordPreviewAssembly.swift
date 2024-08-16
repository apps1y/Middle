//
//  RepasswordPreviewAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.08.2024
//

import UIKit
import NetworkAPI

final class RepasswordPreviewAssembly {
    
    private let networkService: NetworkRecoverProtocol
    private let alertFabric: AlertFabric
    
    private let confirmRecAssembly: ConfirmRecAssembly
    
    init(networkService: NetworkRecoverProtocol, alertFabric: AlertFabric, confirmRecAssembly: ConfirmRecAssembly) {
        self.networkService = networkService
        self.alertFabric = alertFabric
        self.confirmRecAssembly = confirmRecAssembly
    }
    
    func assemble(userEmail: String) -> RepasswordPreviewViewController {
        let router = RepasswordPreviewRouter(alertFabric: alertFabric, confirmRecAssembly: confirmRecAssembly)
        let viewController = RepasswordPreviewViewController()
        let presenter = RepasswordPreviewPresenter(view: viewController, router: router, networkService: networkService, userEmail: userEmail)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
