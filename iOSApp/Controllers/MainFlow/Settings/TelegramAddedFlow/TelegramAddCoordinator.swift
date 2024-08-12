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


final class TelegramNavigationController: UINavigationController {
    var coordinator: TelegramAddCoordinator
    
    init(coordinator: TelegramAddCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        print("navigationController init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("navigationController deinit")
    }
}


protocol TelegramAddCoordinatorProtocol: FlowCoordinator {
    
    var statusTelegramAdded: StatusTelegramAdded { get set }
    
    var navigationController: TelegramNavigationController? { get }
}


final class TelegramAddCoordinator: TelegramAddCoordinatorProtocol {
    
    var statusTelegramAdded: StatusTelegramAdded = .waitingForNumber
    
    weak var navigationController: TelegramNavigationController?
    
    private let tgNumberAssembly: TgNumberAssembly
    private let tgOneTimeCodeAssembly: TgOneTimeCodeAssembly
    private let tgPasswordAssembly: TgPasswordAssembly
    
    init(tgNumberAssembly: TgNumberAssembly, tgOneTimeCodeAssembly: TgOneTimeCodeAssembly, tgPasswordAssembly: TgPasswordAssembly) {
        self.tgNumberAssembly = tgNumberAssembly
        self.tgOneTimeCodeAssembly = tgOneTimeCodeAssembly
        self.tgPasswordAssembly = tgPasswordAssembly
    }
    
    deinit {
        print("TelegramAddCoordinator deinit")
    }
    
    func start() {
        print(statusTelegramAdded)
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
        guard let navigationController else { return }
        let vc = tgNumberAssembly.assemble()
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func pushOneTimeCodeView() {
        guard let navigationController else { return }
        let vc = tgOneTimeCodeAssembly.assemble()
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    private func pushPasswordView() {
        guard let navigationController else { return }
        let vc = tgPasswordAssembly.assemble()
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    private func successResult() {
        navigationController?.dismiss(animated: true)
    }
}
