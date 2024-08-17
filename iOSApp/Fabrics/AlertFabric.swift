//
//  AlertFabric.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 27.07.2024.
//

import UIKit


final class AlertFabric {
    
    /// предупреждающий alert
    /// - Parameter message: текст предупреждения
    /// - Returns: настроенный alert
    func errorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Понятно", style: .default)
        alert.addAction(submitAction)
        return alert
    }
    
    /// предупреждающий alert
    /// - Parameter message: текст предупреждения
    /// - Returns: настроенный alert
    func warningAlertWithAction(title: String = "Предупреждение", message: String, handler: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Понятно", style: .default) { alert in
            handler()
        }
        alert.addAction(submitAction)
        return alert
    }
    
    /// предупреждающий alert
    /// - Parameter message: текст предупреждения
    /// - Returns: настроенный alert
    func warningAlertWithoutAction(title: String = "Предупреждение", message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Понятно", style: .default)
        alert.addAction(submitAction)
        return alert
    }
    
    /// подтверждающий действие action sheet
    /// - Parameter message: текст предупреждения
    /// - Returns: настроенный alert
    func confirmActionSheet(message: String? = nil, actionTitle: String? = nil, handler: @escaping () -> Void) -> UIAlertController {
        let sheet = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        let mainAction = UIAlertAction(title: actionTitle, style: .destructive) { action in
            handler()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        sheet.addAction(mainAction)
        sheet.addAction(cancelAction)
        return sheet
    }
    
    /// подтверждающий действие alert
    /// - Parameter message: текст предупреждения
    /// - Returns: настроенный alert
    func confirmAlert(title: String? = nil, message: String? = nil, actionTitle: String, handler: @escaping () -> Void) -> UIAlertController {
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let mainAction = UIAlertAction(title: actionTitle, style: .destructive) { action in
            handler()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        sheet.addAction(mainAction)
        sheet.addAction(cancelAction)
        return sheet
    }
}
