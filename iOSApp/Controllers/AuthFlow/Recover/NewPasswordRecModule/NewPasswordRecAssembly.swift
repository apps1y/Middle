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
    
    /// Fabrics
    private let alertFabric: AlertFabricProtocol
    
    init(networkService: NetworkRecoverProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, coordinator: FlowCoordinator? = nil, alertFabric: AlertFabricProtocol) {
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.coordinator = coordinator
        self.alertFabric = alertFabric
    }
    
    func assemble(bearer: String) -> NewPasswordRecViewController {
        let router = NewPasswordRecRouter(alertFabric: alertFabric)
        let viewController = NewPasswordRecViewController()
        let presenter = NewPasswordRecPresenter(view: viewController, router: router, networkService: networkService, keychainBearerManager: keychainBearerManager, stringsValidation: stringsValidation, coordinator: coordinator, token: bearer)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
