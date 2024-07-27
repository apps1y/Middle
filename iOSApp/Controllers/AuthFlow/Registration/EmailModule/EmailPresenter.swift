//
//  EmailPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit
import NetworkAPI

protocol EmailPresenterProtocol: AnyObject {
    
    /// запрос на регистрацию
    /// - Parameters:
    ///   - email: почта пользователя
    func register(with email: String)
}

final class EmailPresenter {
    weak var view: EmailViewProtocol?
    var router: EmailRouterInput
    
    private let networkService: NetworkRegisterProtocol
    private let stringsValidation: StringsValidationProtocol

    init(view: EmailViewProtocol?, router: EmailRouterInput, networkService: NetworkRegisterProtocol, stringsValidation: StringsValidationProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.stringsValidation = stringsValidation
    }
}

extension EmailPresenter: EmailPresenterProtocol {
    func register(with email: String) {
        if let errorDescription = stringsValidation.validate(email: email) {
            view?.finishLoading(with: errorDescription)
            return
        }
        view?.startLoading()
        
        networkService.checkAbility(email: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data, let httpCode):
                    if httpCode == 200 {
                        self?.router.pushPasswordView(email: email)
                        self?.view?.finishLoading(with: nil)
                    } else {
                        self?.view?.finishLoading(with: "Почта занята")
                    }
                case .failure(let error):
                    self?.view?.finishLoading(with: nil)
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
}
