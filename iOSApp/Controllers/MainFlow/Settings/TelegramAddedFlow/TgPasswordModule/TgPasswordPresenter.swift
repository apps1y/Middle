//
//  TgPasswordPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit

protocol TgPasswordPresenterProtocol: AnyObject {
    
}

final class TgPasswordPresenter {
    weak var view: TgPasswordViewProtocol?

    init(view: TgPasswordViewProtocol) {
        self.view = view
    }
}

extension TgPasswordPresenter: TgPasswordPresenterProtocol {
    
}
