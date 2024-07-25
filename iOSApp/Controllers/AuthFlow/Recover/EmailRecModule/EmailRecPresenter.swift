//
//  EmailRecPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

protocol EmailRecPresenterProtocol: AnyObject {
    func register(with email: String)
}

final class EmailRecPresenter {
    weak var view: EmailRecViewProtocol?
    var router: EmailRecRouterInput
    
    private let networkService: NetworkRecoverProtocol
    private let stringsValidation: StringsValidationProtocol

    init(view: EmailRecViewProtocol?, router: EmailRecRouterInput, networkService: NetworkRecoverProtocol, stringsValidation: StringsValidationProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.stringsValidation = stringsValidation
    }
}

extension EmailRecPresenter: EmailRecPresenterProtocol {
    func register(with email: String) {
        view?.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view?.finishLoading(with: nil)
            self?.router.pushConfirmView(email: "")
        }
    }
}
