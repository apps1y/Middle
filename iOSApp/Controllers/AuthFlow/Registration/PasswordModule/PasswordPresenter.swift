//
//  PasswordPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

protocol PasswordPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class PasswordPresenter {
    weak var view: PasswordViewProtocol?
    var router: PasswordRouterInput

    private let networkService: NetworkAuthServiceProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let stringsValidation: StringsValidationProtocol
    
    init(view: PasswordViewProtocol?, router: PasswordRouterInput, networkService: NetworkAuthServiceProtocol, keychainBearerManager: KeychainBearerProtocol, stringsValidation: StringsValidationProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.stringsValidation = stringsValidation
    }
}

extension PasswordPresenter: PasswordPresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
