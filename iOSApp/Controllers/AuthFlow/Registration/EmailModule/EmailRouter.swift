//
//  EmailRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

protocol EmailRouterInput {
    
    /// открытие экрана подверждения почты
    func pushConfirmView()
}

final class EmailRouter: EmailRouterInput {
    
    weak var viewController: EmailViewController?
    
    private let confirmAssembly: ConfirmAssembly
    
    init(confirmAssembly: ConfirmAssembly) {
        self.confirmAssembly = confirmAssembly
    }
    
    func pushConfirmView() {
        let view = confirmAssembly.assemble()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
