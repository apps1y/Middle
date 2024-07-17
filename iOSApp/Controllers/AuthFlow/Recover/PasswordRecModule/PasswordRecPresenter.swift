//
//  PasswordRecPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol PasswordRecPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class PasswordRecPresenter {
    weak var view: PasswordRecViewProtocol?
    var router: PasswordRecRouterInput
    
    private let networkService: NetworkAuthServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol

    init(view: PasswordRecViewProtocol?, router: PasswordRecRouterInput, networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
    }
}

extension PasswordRecPresenter: PasswordRecPresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
