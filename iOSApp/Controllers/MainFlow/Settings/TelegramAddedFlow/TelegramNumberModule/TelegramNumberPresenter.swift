//
//  TelegramNumberPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit
import NetworkAPI

protocol TelegramNumberPresenterProtocol: AnyObject {
    
    /// пользователь ввел номер телефона
    /// - Parameters:
    ///   - phoneCountry: +7 или  другой код
    ///   - phoneBody: тело номера телефона
    func enter(phoneCountry: String, phoneBody: String)
}

final class TelegramNumberPresenter {
    weak var view: TelegramNumberViewProtocol?
    var router: TelegramNumberRouterInput
    
    /// DI
    private let networkSevice: NetworkTelegramProtocol
    private let alertFabric: AlertFabric
    private let keychainManager: KeychainManager
    private let cashingRepository: CashingRepositoryProtocol
    
    weak var coordinator: FlowCoordinator?
    
    init(view: TelegramNumberViewProtocol?, router: TelegramNumberRouterInput, networkSevice: NetworkTelegramProtocol, alertFabric: AlertFabric, keychainManager: KeychainManager, cashingRepository: CashingRepositoryProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkSevice = networkSevice
        self.alertFabric = alertFabric
        self.keychainManager = keychainManager
        self.cashingRepository = cashingRepository
        self.coordinator = coordinator
    }
}

extension TelegramNumberPresenter: TelegramNumberPresenterProtocol {
    func enter(phoneCountry: String, phoneBody: String) {
        
        if phoneCountry.count < 2 || phoneBody.count < 3 {
            router.presentWarningAlert(message: "Введите существующий номер телефона.")
            return
        }
        
        guard let token = keychainManager.getToken() else {
            cashingRepository.clearAllCash()
            coordinator?.start()
            return
        }
        let number = phoneCountry + phoneBody
        view?.startLoading()
        networkSevice.sendTelegramCode(token: token, phoneNumber: number) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.finishLoading()
                switch result {
                case .success200(_):
                    self?.router.pushTelegramCodeViewCotroller(phoneNumber: number)
                case .unauthorized:
                    self?.keychainManager.clearToken()
                    self?.cashingRepository.clearAllCash()
                    self?.coordinator?.start()
                case .success400(let status):
                    self?.router.presentWarningAlert(message: status.localizedDescription)
                case .failure(let error):
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
}
