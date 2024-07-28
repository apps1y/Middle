//
//  ConfirmPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit
import NetworkAPI

protocol ConfirmPresenterProtocol: AnyObject {
    
    /// Подтверждение почты
    /// - Parameters:
    ///   - mail: почта, которую ввели на предыдущем экране
    ///   - code: код подтверждения
    func confirm(with code: String)
}

final class ConfirmPresenter {
    weak var view: ConfirmViewProtocol?
    
    /// DI
    private var networkService: NetworkConfirmProtocol
    private var keychainBearerManager: KeychainBearerProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    private var token: String

    init(view: ConfirmViewProtocol?, networkService: NetworkConfirmProtocol, keychainBearerManager: KeychainBearerProtocol, coordinator: FlowCoordinator?, token: String) {
        self.view = view
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.coordinator = coordinator
        self.token = token
    }
}

extension ConfirmPresenter: ConfirmPresenterProtocol {
    func confirm(with code: String) {
        view?.startLoading()
        
        networkService.confirm(token: token, code: code) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data, let httpCode):
                    switch httpCode {
                    case 200:
                        if let token = self?.token {
                            self?.view?.finishLoading(error: nil)
                            self?.keychainBearerManager.saveKey(token)
                            self?.coordinator?.start()
                        } else {
                            self?.view?.finishLoading(error: "Ошибка при обнаружении токена")
                        }
                    case 401:
                        self?.view?.finishLoading(error: "Неверный код")
                    default:
                        self?.view?.finishLoading(error: "Неизвестная ошибка")
                    }
                case .failure(let string):
                    self?.view?.finishLoading(error: string)
                    // alert
                }
            }
        }
    }
}
