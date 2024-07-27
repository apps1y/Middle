//
//  NewPasswordRecAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.07.2024
//

import UIKit
import NetworkAPI

final class NewPasswordRecAssembly {
    
    /// DI
    private var networkService: NetworkRecoverProtocol
    private var keychainBearerManager: KeychainBearerProtocol
    private var stringsValidation: StringsValidationProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(networkService: NetworkRecoverProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
    }
    
    func assemble(bearer: String) -> NewPasswordRecViewController {
        let router = NewPasswordRecRouter()
        let viewController = NewPasswordRecViewController()
        let presenter = NewPasswordRecPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, stringsValidation: stringsValidation, coordinator: coordinator, token: bearer)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
