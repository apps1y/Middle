//
//  NewPasswordRecPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.07.2024
//

import UIKit

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
    private var networkService: NetworkAuthServiceProtocol
    private var keychainBearerManager: KeychainBearerProtocol
    private var stringsValidation: StringsValidationProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?

    init(view: NewPasswordRecViewProtocol?, router: NewPasswordRecRouterInput, networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.coordinator = coordinator
    }
}

extension NewPasswordRecPresenter: NewPasswordRecPresenterProtocol {
    
    func create(firstPassword: String, secondPassword: String) {
        view?.startLoading()
        
        // эмитация запроса на сервер с ответом 3 секунжы
        // TODO: прописать запрос на сервер
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view?.finishLoading(with: nil)
            self?.keychainBearerManager.saveKey("123")
            self?.coordinator?.start()
        }
    }
}
