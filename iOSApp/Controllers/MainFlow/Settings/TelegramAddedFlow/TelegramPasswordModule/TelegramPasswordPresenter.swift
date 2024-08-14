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
    
    /// appCoordinator для выхода из сессии при неправильном запросе
    weak var coordinator: FlowCoordinator?
    
    private let phoneNumber: String
    private let oneTimeCode: String

    init(view: TelegramPasswordViewProtocol?, router: TelegramPasswordRouterInput, networkSevice: NetworkTelegramProtocol, keychainManager: KeychainManager, coordinator: FlowCoordinator?, phoneNumber: String, oneTimeCode: String) {
        self.view = view
        self.router = router
        self.networkSevice = networkSevice
        self.keychainManager = keychainManager
        self.coordinator = coordinator
        self.phoneNumber = phoneNumber
        self.oneTimeCode = oneTimeCode
    }
}

extension TelegramPasswordPresenter: TelegramPasswordPresenterProtocol {
    func enter(password: String) {
        
    }
}
