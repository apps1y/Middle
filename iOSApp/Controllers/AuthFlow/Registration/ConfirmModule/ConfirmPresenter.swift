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
    var router: ConfirmRouterInput
    
    /// DI
    private var networkService: NetworkConfirmProtocol
    private var keychainBearerManager: KeychainBearerProtocol
    weak var coordinator: FlowCoordinator?
    private var token: String

    init(view: ConfirmViewProtocol?, router: ConfirmRouterInput, networkService: NetworkConfirmProtocol, keychainBearerManager: KeychainBearerProtocol, coordinator: FlowCoordinator?, token: String) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.coordinator = coordinator
        self.token = token
    }
}

extension ConfirmPresenter: ConfirmPresenterProtocol {
    func confirm(with code: String) {
        view?.startLoading()
        
        let token = token
        
        networkService.confirm(token: token, code: code) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success200(let data):
                    self?.view?.finishLoading(error: nil)
                    self?.keychainBearerManager.saveKey(token)
                    self?.coordinator?.start()
                case .success400(let status):
                    self?.view?.finishLoading(error: status.localizedDescription)
                case .failure(let error):
                    self?.view?.finishLoading(error: nil)
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
}
