//
//  EmailRecPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol EmailRecPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class EmailRecPresenter {
    weak var view: EmailRecViewProtocol?
    var router: EmailRecRouterInput
    
    private let networkService: NetworkAuthServiceProtocol
    private let stringsValidation: StringsValidationProtocol

    init(view: EmailRecViewProtocol?, router: EmailRecRouterInput, networkService: NetworkAuthServiceProtocol, stringsValidation: StringsValidationProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.stringsValidation = stringsValidation
    }
}

extension EmailRecPresenter: EmailRecPresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
