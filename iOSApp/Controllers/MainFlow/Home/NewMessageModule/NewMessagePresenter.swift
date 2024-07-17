//
//  NewMessagePresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol NewMessagePresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class NewMessagePresenter {
    weak var view: NewMessageViewProtocol?
    var router: NewMessageRouterInput

    init(view: NewMessageViewProtocol, router: NewMessageRouterInput) {
        self.view = view
        self.router = router
    }
}

extension NewMessagePresenter: NewMessagePresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
