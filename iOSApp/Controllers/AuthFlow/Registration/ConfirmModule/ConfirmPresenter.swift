//
//  ConfirmPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit

protocol ConfirmPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class ConfirmPresenter {
    weak var view: ConfirmViewProtocol?
    var router: ConfirmRouterInput

    init(view: ConfirmViewProtocol, router: ConfirmRouterInput) {
        self.view = view
        self.router = router
    }
}

extension ConfirmPresenter: ConfirmPresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
