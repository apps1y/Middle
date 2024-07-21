//
//  EmailPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

protocol EmailPresenterProtocol: AnyObject {
    
    /// запрос на регистрацию
    /// - Parameters:
    ///   - email: почта пользователя
    func register(with email: String)
}

final class EmailPresenter {
    weak var view: EmailViewProtocol?
    var router: EmailRouterInput
    
    private let networkService: NetworkAuthServiceProtocol
    private let stringsValidation: StringsValidationProtocol

    init(view: EmailViewProtocol?, router: EmailRouterInput, networkService: NetworkAuthServiceProtocol, stringsValidation: StringsValidationProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.stringsValidation = stringsValidation
    }
}

extension EmailPresenter: EmailPresenterProtocol {
    func register(with email: String) {
        view?.startLoading()
        
        if let errorDescription = stringsValidation.validate(email: email) {
            view?.finishLoading(with: errorDescription)
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view?.finishLoading(with: nil)
            self?.router.pushConfirmView()
        }
    }
}
