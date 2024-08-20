//
//  HomeRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol HomeRouterInput {
    func presentWarningAlert(message: String)
}

final class HomeRouter: HomeRouterInput {
    weak var viewController: HomeViewController?
    
    func presentWarningAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Понятно", style: .default)
        alert.addAction(submitAction)
        viewController?.present(alert, animated: true)
    }
}
