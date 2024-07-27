//
//  AlertFabric.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 27.07.2024.
//

import UIKit

protocol AlertFabricProtocol {
    
    /// предупреждающий alert
    /// - Parameter text: текст предупреждения
    /// - Returns: настроенный alert
    func errorAuthAlert(message: String) -> UIAlertController
}

final class AlertFabric: AlertFabricProtocol {
    func errorAuthAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Понятно", style: .default)
        alert.addAction(submitAction)
        return alert
    }
}
