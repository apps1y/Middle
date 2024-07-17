//
//  NewMessageAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

final class NewMessageAssembly {
    
    func assemble() -> NewMessageViewController {
        let router = NewMessageRouter()
        let viewController = NewMessageViewController()
        let presenter = NewMessagePresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
