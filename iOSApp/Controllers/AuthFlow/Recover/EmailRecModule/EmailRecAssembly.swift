//
//  EmailRecAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

final class EmailRecAssembly {
    
    /// DI
    private let networkService: NetworkRecoverProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// Assembly's
    private let confirmRecAssembly: ConfirmRecAssembly
    
    /// Fabrics
    private let alertFabric: AlertFabricProtocol
    
    init(networkService: NetworkRecoverProtocol, stringsValidation: StringsValidationProtocol, confirmRecAssembly: ConfirmRecAssembly, alertFabric: AlertFabricProtocol) {
        self.networkService = networkService
        self.stringsValidation = stringsValidation
        self.confirmRecAssembly = confirmRecAssembly
        self.alertFabric = alertFabric
    }
    
    func assemble(email: String?) -> EmailRecViewController {
        let router = EmailRecRouter(confirmRecAssembly: confirmRecAssembly, alertFabric: alertFabric)
        let viewController = EmailRecViewController(email: email)
        let presenter = EmailRecPresenter(view: viewController, router: router, networkService: networkService, stringsValidation: stringsValidation)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
