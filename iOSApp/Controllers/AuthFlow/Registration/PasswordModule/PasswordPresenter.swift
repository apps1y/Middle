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
    func input(firstPassword: String, secondPassword: String)
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
    func input(firstPassword: String, secondPassword: String) {
        if let error = stringsValidation.validate(password: firstPassword) {
            view?.finishLoading(with: (.first, error))
            return
        }
        
        if firstPassword != secondPassword {
            view?.finishLoading(with: (.second, "Пароли не совпадают."))
            return
        }
        
        view?.startLoading()
        
        networkService.register(email: email, password: firstPassword) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data, let httpCode):
                    if httpCode == 200, let data {
                        self?.router.pushConfirmView(bearer: data.token)
                    } else {
                        self?.view?.finishLoading(with: (.first, "Ошибка"))
                    }
                case .failure(let string):
                    self?.view?.finishLoading(with: (.first, string))
                }
            }
        }
    }
}
