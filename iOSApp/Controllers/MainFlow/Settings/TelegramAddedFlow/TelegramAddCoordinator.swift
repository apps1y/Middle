//
//  TelegramAddCoordinator.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 09.08.2024.
//

import UIKit

enum StatusTelegramAdded {
    case waitingForNumber
    case waitingForOneTimeCode
    case waitingForPassword
    case success
}

protocol TelegramAddCoordinatorProtocol: FlowCoordinator {
    
    var statusTelegramAdded: StatusTelegramAdded { get set }
    
}

final class TelegramAddCoordinator: TelegramAddCoordinatorProtocol {
    
    var statusTelegramAdded: StatusTelegramAdded = .waitingForNumber
    
    private let navigationController: UINavigationController
    
    private let tgNumberAssembly: TgNumberAssembly
    private let tgOneTimeCodeAssembly: TgOneTimeCodeAssembly
    private let tgPasswordAssembly: TgPasswordAssembly
    
    init(navigationController: UINavigationController, tgNumberAssembly: TgNumberAssembly, tgOneTimeCodeAssembly: TgOneTimeCodeAssembly, tgPasswordAssembly: TgPasswordAssembly) {
        self.navigationController = navigationController
        self.tgNumberAssembly = tgNumberAssembly
        self.tgOneTimeCodeAssembly = tgOneTimeCodeAssembly
        self.tgPasswordAssembly = tgPasswordAssembly
    }
    
    func start() {
        switch statusTelegramAdded {
        case .waitingForNumber:
            pushNumberView()
        case .waitingForOneTimeCode:
            pushOneTimeCodeView()
        case .waitingForPassword:
            pushPasswordView()
        case .success:
            successResult()
        }
    }
    
    private func pushNumberView() {
        let vc = tgNumberAssembly.assemble()
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func pushOneTimeCodeView() {
        let vc = tgOneTimeCodeAssembly.assemble()
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func pushPasswordView() {
        let vc = tgPasswordAssembly.assemble()
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func successResult() {
        navigationController.dismiss(animated: true)
    }
}
