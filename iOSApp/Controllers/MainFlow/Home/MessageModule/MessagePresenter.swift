//
//  MessagePresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol MessagePresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class MessagePresenter {
    weak var view: MessageViewProtocol?
    var router: MessageRouterInput

    init(view: MessageViewProtocol, router: MessageRouterInput) {
        self.view = view
        self.router = router
    }
}

extension MessagePresenter: MessagePresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
