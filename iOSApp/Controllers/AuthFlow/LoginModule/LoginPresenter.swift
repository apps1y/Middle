//
//  LoginPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit

protocol LoginPresenterProtocol: AnyObject {
    
    /// запрос на вход пользователя
    /// - Parameters:
    ///   - error: какое поле загорится красным, текст ошибки для пользователя
    func loginRequest(with email: String, password: String)
    
    /// открытие экрана регистрации
    func openRegistration()
    
    /// открытие экрана восстановления
    func openRecover(with email: String)
}

final class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterInput
    
    /// DI
    private let networkService: NetworkAuthServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// координатор для перезагрузки
    weak var coordinator: FlowCoordinator?

    init(view: LoginViewProtocol?, router: LoginRouterInput, networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.coordinator = coordinator
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func loginRequest(with email: String, password: String) {
        if stringsValidation.validate(email: email) != nil {
            view?.finishLoading(withErrorOf: .passwordTextField)
            return
        }
        
        view?.startLoading()
        
        /// эмитация запроса на сервер с ответом 3 секунжы
        // TODO: прописать запрос на сервер
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view?.finishLoading(withErrorOf: nil)
            self?.keychainBearerManager.saveKey("key")
            self?.coordinator?.start()
        }
    }
    
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
}
