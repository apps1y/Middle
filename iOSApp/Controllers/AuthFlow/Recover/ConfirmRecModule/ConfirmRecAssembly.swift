//
//  ConfirmRecAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.07.2024
//

import UIKit
import NetworkAPI

final class ConfirmRecAssembly {
    
    /// DI
    private let networkService: NetworkRecoverProtocol
    
    /// Assembly's
    private let newPasswordRecAssembly: NewPasswordRecAssembly
    
    /// Fabrics
    private let alertFabric: AlertFabric
    
    init(networkService: NetworkRecoverProtocol, newPasswordRecAssembly: NewPasswordRecAssembly, alertFabric: AlertFabric) {
        self.networkService = networkService
        self.newPasswordRecAssembly = newPasswordRecAssembly
        self.alertFabric = alertFabric
    }
    
    func assemble(email: String) -> ConfirmRecViewController {
        let router = ConfirmRecRouter(newPasswordRecAssembly: newPasswordRecAssembly, alertFabric: alertFabric)
        let viewController = ConfirmRecViewController()
        let presenter = ConfirmRecPresenter(view: viewController, router: router,
                                            networkService: networkService, email: email)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
