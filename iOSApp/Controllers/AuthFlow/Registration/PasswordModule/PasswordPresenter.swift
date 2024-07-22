//
//  PasswordPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

protocol PasswordPresenterProtocol: AnyObject {
    
    /// направление придуманного пароля
    /// - Parameters:
    ///   - firstPassword: пароль
    ///   - secondPassword: подтверждение пароля
    func create(firstPassword: String, secondPassword: String)
}

final class PasswordPresenter {
    weak var view: PasswordViewProtocol?
    var router: PasswordRouterInput

    /// DI
    private let networkService: NetworkAuthServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(view: PasswordViewProtocol?, router: PasswordRouterInput, networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.coordinator = coordinator
    }
}

extension PasswordPresenter: PasswordPresenterProtocol {
    func create(firstPassword: String, secondPassword: String) {
        view?.startLoading()
        
        // эмитация запроса на сервер с ответом 3 секунжы
        // TODO: прописать запрос на сервер
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view?.finishLoading(with: nil)
            self?.coordinator?.start()
        }
    }
}
