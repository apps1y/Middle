//
//  HomeRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol HomeRouterInput {
    
    func presentUnravelViewController()
    
    /// показ предупреждения об ошибке
    /// - Parameter message: текст предупреждения
    func presentWarningAlert(message: String)
}

final class HomeRouter: HomeRouterInput {
    weak var viewController: HomeViewController?
    
    private let alertFabric: AlertFabric
    private let unravelAssembly: UnravelAssembly
    
    init(alertFabric: AlertFabric, unravelAssembly: UnravelAssembly) {
        self.alertFabric = alertFabric
        self.unravelAssembly = unravelAssembly
    }
    
    func presentUnravelViewController() {
        let view = unravelAssembly.assemble()
        let navigationView = UINavigationController(rootViewController: view)
        view.modalPresentationStyle = .formSheet
        viewController?.present(navigationView, animated: true)
    }
    
    func presentWarningAlert(message: String) {
        let alert = alertFabric.errorAlert(message: message)
        viewController?.present(alert, animated: true)
    }
}
