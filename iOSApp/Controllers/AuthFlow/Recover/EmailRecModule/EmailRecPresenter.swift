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
        if let error = stringsValidation.validate(email: email) {
            view?.finishLoading(with: error)
            return
        }
        
        view?.startLoading()
        
        networkService.sendCode(email: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success200(let data):
                    self?.view?.finishLoading(with: nil)
                    self?.router.pushConfirmView(email: email)
                case .success400(let status):
                    self?.view?.finishLoading(with: status.localizedDescription)
                case .failure(let error):
                    self?.view?.finishLoading(with: nil)
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
}
