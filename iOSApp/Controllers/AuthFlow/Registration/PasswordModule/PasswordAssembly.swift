//
//  PasswordAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

final class PasswordAssembly {
    
    func assemble() -> PasswordViewController {
        let router = PasswordRouter()
        let viewController = PasswordViewController()
        let presenter = PasswordPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
