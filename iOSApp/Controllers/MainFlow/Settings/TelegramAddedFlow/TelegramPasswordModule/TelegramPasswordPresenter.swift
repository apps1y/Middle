//
//  TelegramPasswordPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit
import NetworkAPI

protocol TelegramPasswordPresenterProtocol: AnyObject {
    
    /// пользователь ввел номер телефона
    /// - Parameter password: пароль
    func enter(password: String)
}

final class TelegramPasswordPresenter {
    weak var view: TelegramPasswordViewProtocol?
    var router: TelegramPasswordRouterInput
    
    /// DI
    private let networkSevice: NetworkTelegramProtocol
    private let keychainManager: KeychainManager
    private let cashingRepository: CashingRepositoryProtocol
    
    /// appCoordinator для выхода из сессии при неправильном запросе
    weak var coordinator: FlowCoordinator?
    
    private let phoneNumber: String
    private let oneTimeCode: String

    init(view: TelegramPasswordViewProtocol?, router: TelegramPasswordRouterInput, networkSevice: NetworkTelegramProtocol, keychainManager: KeychainManager, cashingRepository: CashingRepositoryProtocol, coordinator: FlowCoordinator?, phoneNumber: String, oneTimeCode: String) {
        self.view = view
        self.router = router
        self.networkSevice = networkSevice
        self.keychainManager = keychainManager
        self.cashingRepository = cashingRepository
        self.coordinator = coordinator
        self.phoneNumber = phoneNumber
        self.oneTimeCode = oneTimeCode
    }
}

extension TelegramPasswordPresenter: TelegramPasswordPresenterProtocol {
    func enter(password: String) {
        guard let token = keychainManager.getToken() else {
            cashingRepository.clearAllCash()
            coordinator?.start()
            return
        }
        
        view?.startLoading()
        
        networkSevice.addTelegramAccount(token: token, code: oneTimeCode, password: password, phoneNumber: phoneNumber) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.finishLoading()
                switch result {
                case .success200(let data):
                    switch TelegramStatusValidation.validate(stringStatus: data.status) {
                    case .sussess: 
                        let account = TelegramAccountModel(name: data.session.name, phone: data.session.phone)
                        self?.router.dismissViewWithCompletion(account: account)
                    case .invalidCode: self?.router.warningIncorrectOneTimeCode()
                    case .invalidPassword: self?.router.warningIncorrectPassword()
                    case .other: self?.router.warningAuknownError()
                    }
                case .unauthorized:
                    self?.keychainManager.clearToken()
                    self?.cashingRepository.clearAllCash()
                    self?.coordinator?.start()
                case .success400(_):
                    self?.router.presentWarningAlert(message: "Неизвестная ошибка.")
                case .failure(let error):
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
}
