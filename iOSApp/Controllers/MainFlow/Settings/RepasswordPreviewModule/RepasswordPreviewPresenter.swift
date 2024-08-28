//
//  RepasswordPreviewPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.08.2024
//

import UIKit
import NetworkAPI

protocol RepasswordPreviewPresenterProtocol: AnyObject {
    
    /// подготовка к открытию экрана подтверждения
    func prepareAccountConfirmation()
}

final class RepasswordPreviewPresenter {
    weak var view: RepasswordPreviewViewProtocol?
    var router: RepasswordPreviewRouterInput
    
    private let networkService: NetworkRecoverProtocol
    
    private let userEmail: String
    
    init(view: RepasswordPreviewViewProtocol?, router: RepasswordPreviewRouterInput, networkService: NetworkRecoverProtocol, userEmail: String) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.userEmail = userEmail
    }
}

extension RepasswordPreviewPresenter: RepasswordPreviewPresenterProtocol {
    func prepareAccountConfirmation() {
        view?.startLoading()
        
        networkService.sendCode(email: userEmail) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.finishLoading()
                switch result {
                case .success200(_):
                    guard let userEmail = self?.userEmail else {
                        self?.router.presentWarningAlert(message: "Неизвестная ошибка")
                        return
                    }
                    self?.router.pushConfirmCodeController(userEmail: userEmail)
                case .success400(let status):
                    self?.router.presentWarningAlert(message: status.localizedDescription)
                case .failure(let error):
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
}
