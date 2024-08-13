//
//  TgOneTimeCodePresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit

protocol TgOneTimeCodePresenterProtocol: AnyObject {
    
    /// пользователь ввел код подтверждения
    /// - Parameter code: код
    func enter(code: String)
}

final class TgOneTimeCodePresenter {
    weak var view: TgOneTimeCodeViewProtocol?
    
    weak var telegramAddCoordinator: TelegramAddCoordinatorProtocol?

    init(view: TgOneTimeCodeViewProtocol?, telegramAddCoordinator: TelegramAddCoordinatorProtocol?) {
        self.view = view
        self.telegramAddCoordinator = telegramAddCoordinator
    }
}

extension TgOneTimeCodePresenter: TgOneTimeCodePresenterProtocol {
    func enter(code: String) {
        view?.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.view?.finishLoading(startAgain: true)
            self?.telegramAddCoordinator?.statusTelegramAdded = .waitingForPassword
            self?.telegramAddCoordinator?.start()
        }
    }
}
