//
//  PasswordPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit
import NetworkAPI

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
    private let networkService: NetworkRegisterProtocol
    private let stringsValidation: StringsValidationProtocol
    
    /// Data
    private var email: String
    
    init(view: PasswordViewProtocol?, router: PasswordRouterInput, networkService: NetworkRegisterProtocol, stringsValidation: StringsValidationProtocol, email: String) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.stringsValidation = stringsValidation
        self.email = email
    }
}

extension PasswordPresenter: PasswordPresenterProtocol {
    func create(firstPassword: String, secondPassword: String) {
        view?.startLoading()
        
        // эмитация запроса на сервер с ответом 3 секунжы
        // TODO: прописать запрос на сервер
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view?.finishLoading(with: nil)
            self?.router.pushConfirmView(bearer: "")
        }
    }
}
