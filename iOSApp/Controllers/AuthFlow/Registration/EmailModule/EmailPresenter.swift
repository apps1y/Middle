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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.view?.finishLoading(with: nil)
            self?.router.pushPasswordView(email: "") // success email enter
        }
    }
}
