//
//  TgPasswordPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit

protocol TgPasswordPresenterProtocol: AnyObject {
    
    /// пользователь ввел номер телефона
    /// - Parameter password: пароль
    func enter(password: String)
}

final class TgPasswordPresenter {
    weak var view: TgPasswordViewProtocol?

    weak var telegramAddCoordinator: TelegramAddCoordinatorProtocol?
    
    init(view: TgPasswordViewProtocol?, telegramAddCoordinator: TelegramAddCoordinatorProtocol?) {
        self.view = view
        self.telegramAddCoordinator = telegramAddCoordinator
    }
}

extension TgPasswordPresenter: TgPasswordPresenterProtocol {
    func enter(password: String) {
        telegramAddCoordinator?.statusTelegramAdded = .success
        telegramAddCoordinator?.start()
    }
}
