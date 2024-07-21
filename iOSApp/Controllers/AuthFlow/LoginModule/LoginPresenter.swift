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
    
    func openRecover(with email: String)
}

final class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterInput
    
    private let networkService: NetworkAuthServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    private var reloadCoordinator: () -> Void

    init(view: LoginViewProtocol?, router: LoginRouterInput, networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol, reloadCoordinator: @escaping () -> Void) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
        self.reloadCoordinator = reloadCoordinator
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func loginRequest(with email: String, password: String) {
        
        view?.startLoading()
        
        if let errorDescription = stringsValidation.validate(email: email) {
            view?.finishLoading(with: (.emailTextField, errorDescription))
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view?.finishLoading(with: nil)
            self?.reloadCoordinator()
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
