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
    
    init(view: ConfirmRecViewProtocol?, router: ConfirmRecRouterInput, networkService: NetworkRecoverProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
}

extension ConfirmRecPresenter: ConfirmRecPresenterProtocol {
    func confirm(mail: String, with code: String) {
        view?.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.view?.finishLoading(error: nil)
            self?.router.pushNewPasswordView(bearer: "")
        }
    }
}
