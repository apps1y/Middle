//
//  TgNumberPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit
import NetworkAPI

protocol TgNumberPresenterProtocol: AnyObject {
    
    /// пользователь ввел номер телефона
    /// - Parameter number: номер телефона
    func enter(phone number: String)
}

final class TgNumberPresenter {
    weak var view: TgNumberViewProtocol?
    
    /// DI
    private let networkSevice: NetworkProfileProtocol
    private let alertFabric: AlertFabric
    
    /// coordinator
    weak var telegramAddCoordinator: TelegramAddCoordinatorProtocol?

    init(view: TgNumberViewProtocol?, networkSevice: NetworkProfileProtocol, alertFabric: AlertFabric, telegramAddCoordinator: TelegramAddCoordinatorProtocol?) {
        self.view = view
        self.networkSevice = networkSevice
        self.alertFabric = alertFabric
        self.telegramAddCoordinator = telegramAddCoordinator
    }
    
    deinit {
        print("TgNumberPresenterProtocol deinit")
    }
}

extension TgNumberPresenter: TgNumberPresenterProtocol {
    func enter(phone number: String) {
        // локальные проверки
        
        view?.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.view?.finishLoading()
            self?.telegramAddCoordinator?.statusTelegramAdded = .waitingForOneTimeCode
            self?.telegramAddCoordinator?.start()
        }
    }
}
