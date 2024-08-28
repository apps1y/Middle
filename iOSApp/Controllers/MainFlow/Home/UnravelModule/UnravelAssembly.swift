//
//  UnravelAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.08.2024
//

import UIKit

final class UnravelAssembly {
    
    func assemble() -> UnravelViewController {
        let router = UnravelRouter()
        let viewController = UnravelViewController()
        let presenter = UnravelPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
