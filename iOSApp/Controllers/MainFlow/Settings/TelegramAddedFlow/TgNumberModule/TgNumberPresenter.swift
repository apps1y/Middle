//
//  TgNumberPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit
import NetworkAPI

protocol TgNumberPresenterProtocol: AnyObject {
    
}

final class TgNumberPresenter {
    weak var view: TgNumberViewProtocol?
    
    /// DI
    private let networkSevice: NetworkMainProtocol
    
    /// coordinator
    weak var telegramAddCoordinatorProtocol: TelegramAddCoordinatorProtocol?

    init(view: TgNumberViewProtocol?, networkSevice: NetworkMainProtocol, telegramAddCoordinatorProtocol: TelegramAddCoordinatorProtocol?) {
        self.view = view
        self.networkSevice = networkSevice
        self.telegramAddCoordinatorProtocol = telegramAddCoordinatorProtocol
    }
}

extension TgNumberPresenter: TgNumberPresenterProtocol {
    
}
