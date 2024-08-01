//
//  LoginPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit
import NetworkAPI

protocol LoginPresenterProtocol: AnyObject {
    
    /// запрос на вход пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - password: пароль юзера
    func login(with email: String, password: String)
    
    /// открытие экрана регистрации
    func openRegistration()
    
    /// открытие экрана восстановления
    func openRecover(with email: String)
}

final class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterInput
    
    /// DI
    private let networkService: NetworkAuthProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// координатор для перезагрузки
    weak var coordinator: FlowCoordinator?

    init(view: LoginViewProtocol?, router: LoginRouterInput, networkService: NetworkAuthProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.coordinator = coordinator
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func openRegistration() {
        router.pushEmailViewController()
    }
    
    
    func openRecover(with email: String) {
        if stringsValidation.validate(email: email) == nil {
            router.presentEmailRecViewController(email: email)
        } else {
            router.presentEmailRecViewController(email: nil)
        }
        
    }
    
    
    func login(with email: String, password: String) {
        /// проверка на валидность почты
        guard stringsValidation.validate(email: email) == nil else {
            view?.finishLoading(withErrorOf: .emailTextField)
            return
        }
        /// проверка на валидность пароля
        guard stringsValidation.isValid(password) else {
            view?.finishLoading(withErrorOf: .passwordTextField)
            return
        }
        view?.startLoading()
        
        networkService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success200(let data):
                    self?.view?.finishLoading(withErrorOf: nil)
                    if data.confirmed {
                        self?.keychainBearerManager.save(token: data.token)
                        self?.coordinator?.start()
                    } else {
                        self?.router.pushConfirmViewController(token: data.token)
                    }
                case .success400(let status):
                    switch status {
                    case .notFound:
                        self?.view?.finishLoading(withErrorOf: .emailTextField)
                    case .unauthorized:
                        self?.view?.finishLoading(withErrorOf: .passwordTextField)
                    default:
                        self?.view?.finishLoading(withErrorOf: nil)
                        self?.router.presentWarningAlert(message: "Неизвестная ошибка.")
                    }
                case .failure(let error):
                    self?.view?.finishLoading(withErrorOf: nil)
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
    
}
