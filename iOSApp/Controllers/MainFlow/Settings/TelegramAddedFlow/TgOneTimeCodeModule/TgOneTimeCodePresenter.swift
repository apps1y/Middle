//
//  TgOneTimeCodePresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit

protocol TgOneTimeCodePresenterProtocol: AnyObject {
    
}

final class TgOneTimeCodePresenter {
    weak var view: TgOneTimeCodeViewProtocol?

    init(view: TgOneTimeCodeViewProtocol) {
        self.view = view
    }
}

extension TgOneTimeCodePresenter: TgOneTimeCodePresenterProtocol {
    
}
