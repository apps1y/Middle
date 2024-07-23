//
//  EmailRecRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol EmailRecRouterInput {
    func pushConfirmView(email: String)
}

final class EmailRecRouter: EmailRecRouterInput {
    
    weak var viewController: EmailRecViewController?
    private let confirmRecAssembly: ConfirmRecAssembly
    
    init(confirmRecAssembly: ConfirmRecAssembly) {
        self.confirmRecAssembly = confirmRecAssembly
    }
    
    func pushConfirmView(email: String) {
        let view = confirmRecAssembly.assemble(email: email)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
