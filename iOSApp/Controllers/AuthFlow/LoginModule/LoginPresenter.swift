//
//  LoginPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit

protocol LoginPresenterProtocol: AnyObject {
    func loginRequest(with email: String, password: String)
    
    func openRegistration()
    
    func openRecover()
}

final class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterInput
    
    private let networkService: NetworkAuthServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol

    init(view: LoginViewProtocol?, router: LoginRouterInput, networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func loginRequest(with email: String, password: String) {
        
        if let errorDescription = stringsValidation.validate(email: email) {
            view?.finishLoading(with: (.emailTextField, errorDescription))
            return
        }
        
        view?.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view?.finishLoading(with: nil)
        }
    }
    
    func openRegistration() {
        router.pushEmailViewController()
    }
    
    func openRecover() {
        router.presentEmailRecViewController()
    }
}
