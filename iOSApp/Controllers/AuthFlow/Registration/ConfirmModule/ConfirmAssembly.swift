//
//  ConfirmAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit

final class ConfirmAssembly {
    
    /// DI
    private let networkService: NetworkAuthServiceProtocol
    
    /// Assembly's
    private let passwordAssembly: PasswordAssembly
    
    init(networkService: NetworkAuthServiceProtocol, passwordAssembly: PasswordAssembly) {
        self.networkService = networkService
        self.passwordAssembly = passwordAssembly
    }
    
    func assemble() -> ConfirmViewController {
        let router = ConfirmRouter(passwordAssembly: passwordAssembly)
        let viewController = ConfirmViewController()
        let presenter = ConfirmPresenter(view: viewController, router: router, networkService: networkService)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
