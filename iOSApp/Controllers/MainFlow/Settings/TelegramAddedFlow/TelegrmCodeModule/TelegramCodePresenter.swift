//
//  TelegramCodePresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit


protocol TelegramCodePresenterProtocol: AnyObject {
    /// загрузка view
    func viewDidLoaded()
    
    /// пользователь ввел код подтверждения
    /// - Parameter code: код
    func enter(code: String)
}

final class TelegramCodePresenter {
    weak var view: TelegramCodeViewProtocol?
    var router: TelegramCodeRouterInput
    
    private let phoneNumber: String

    init(view: TelegramCodeViewProtocol?, router: TelegramCodeRouterInput, phoneNumber: String) {
        self.view = view
        self.router = router
        self.phoneNumber = phoneNumber
    }
}

extension TelegramCodePresenter: TelegramCodePresenterProtocol {
    func viewDidLoaded() {
        // format number
        let description = "Мы отправили код через Telegram на другое устройство, где авторизован \(phoneNumber)."
        view?.setDescriptionLabel(text: description)
    }
    
    func enter(code: String) {
        router.pushPasswordViewController(number: phoneNumber, oneTimeCode: code)
    }
}
