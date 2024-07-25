//
//  ConfirmPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit

protocol ConfirmPresenterProtocol: AnyObject {
    
    /// Подтверждение почты
    /// - Parameters:
    ///   - mail: почта, которую ввели на предыдущем экране
    ///   - code: код подтверждения
    func confirm(mail: String, with code: String)
}

final class ConfirmPresenter {
    weak var view: ConfirmViewProtocol?
    
    /// DI
    private var networkService: NetworkAuthServiceProtocol
    private var keychainBearerManager: KeychainBearerProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?

    init(view: ConfirmViewProtocol?, networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.coordinator = coordinator
    }
}

extension ConfirmPresenter: ConfirmPresenterProtocol {
    func confirm(mail: String, with code: String) {
        view?.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.view?.finishLoading(error: nil)
            self?.keychainBearerManager.saveKey("123")
            self?.coordinator?.start()
        }
    }
}
