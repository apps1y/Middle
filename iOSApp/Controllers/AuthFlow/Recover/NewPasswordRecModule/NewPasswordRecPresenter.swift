//
//  NewPasswordRecPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.07.2024
//

import UIKit
import NetworkAPI

protocol NewPasswordRecPresenterProtocol: AnyObject {
    
    /// направление придуманного пароля
    /// - Parameters:
    ///   - firstPassword: пароль
    ///   - secondPassword: подтверждение пароля
    func create(firstPassword: String, secondPassword: String)
}

final class NewPasswordRecPresenter {
    weak var view: NewPasswordRecViewProtocol?
    var router: NewPasswordRecRouterInput
    
    /// DI
    private var networkService: NetworkRecoverProtocol
    private var keychainBearerManager: KeychainBearerProtocol
    private var stringsValidation: StringsValidationProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    var token: String

    init(view: NewPasswordRecViewProtocol?, router: NewPasswordRecRouterInput, networkService: NetworkRecoverProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, coordinator: FlowCoordinator?, token: String) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.coordinator = coordinator
        self.token = token
    }
}

extension NewPasswordRecPresenter: NewPasswordRecPresenterProtocol {
    
    func create(firstPassword: String, secondPassword: String) {
        if let error = stringsValidation.validate(password: firstPassword) {
            view?.finishLoading(with: (.first, error))
            return
        }
        
        if firstPassword != secondPassword {
            view?.finishLoading(with: (.second, "Пароли не совпадают."))
            return
        }
        
        view?.startLoading()
        
        let token = token
        
        networkService.updatePassword(token: token, password: firstPassword) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success200(let data):
                    self?.view?.finishLoading(with: nil)
                    self?.keychainBearerManager.save(token: data.token)
                    self?.coordinator?.start()
                case .success400(let status):
                    self?.view?.finishLoading(with: (.none, status.localizedDescription))
                case .failure(let error):
                    self?.view?.finishLoading(with: nil)
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
}
