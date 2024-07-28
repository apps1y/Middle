//
//  ConfirmRecPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.07.2024
//

import UIKit
import NetworkAPI

protocol ConfirmRecPresenterProtocol: AnyObject {
    
    /// Подтверждение почты
    /// - Parameters:
    ///   - mail: почта, которую ввели на предыдущем экране
    ///   - code: код подтверждения
    func confirm(mail: String, with code: String)
}

final class ConfirmRecPresenter {
    weak var view: ConfirmRecViewProtocol?
    var router: ConfirmRecRouterInput

    private let networkService: NetworkRecoverProtocol
    private let email: String
    
    init(view: ConfirmRecViewProtocol?, router: ConfirmRecRouterInput, networkService: NetworkRecoverProtocol, email: String) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.email = email
    }
}

extension ConfirmRecPresenter: ConfirmRecPresenterProtocol {
    func confirm(mail: String, with code: String) {
        view?.startLoading()
        
        networkService.confirmResert(email: email, code: code) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data, let httpCode):
                    if httpCode == 200, let data {
                        self?.view?.finishLoading(error: nil)
                        self?.router.pushNewPasswordView(bearer: data.token)
                    } else {
                        self?.view?.finishLoading(error: "Неверный код")
                    }
                case .failure(let error):
                    self?.view?.finishLoading(error: nil)
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
}
