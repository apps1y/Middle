//
//  LoginPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit

protocol LoginPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterInput
    
    private let networkService: NetworkAuthServiceProtocol
    private let authManager: AuthManager
    private let stringsValidation: StringsValidationProtocol

    init(view: LoginViewProtocol?, router: LoginRouterInput, networkService: NetworkAuthServiceProtocol, authManager: AuthManager, stringsValidation: StringsValidationProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.authManager = authManager
        self.stringsValidation = stringsValidation
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
