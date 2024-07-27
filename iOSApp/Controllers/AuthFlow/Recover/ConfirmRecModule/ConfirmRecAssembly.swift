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
    
    init(networkService: NetworkRecoverProtocol, newPasswordRecAssembly: NewPasswordRecAssembly) {
        self.networkService = networkService
        self.newPasswordRecAssembly = newPasswordRecAssembly
    }
    
    func assemble(email: String) -> ConfirmRecViewController {
        let router = ConfirmRecRouter(newPasswordRecAssembly: newPasswordRecAssembly)
        let viewController = ConfirmRecViewController()
        let presenter = ConfirmRecPresenter(view: viewController, router: router,
                                            networkService: networkService, email: email)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
