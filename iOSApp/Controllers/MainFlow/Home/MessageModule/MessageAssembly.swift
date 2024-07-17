//
//  MessageAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

final class MessageAssembly {
    
    func assemble() -> MessageViewController {
        let router = MessageRouter()
        let viewController = MessageViewController()
        let presenter = MessagePresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
