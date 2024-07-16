//
//  PasswordPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

protocol PasswordPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class PasswordPresenter {
    weak var view: PasswordViewProtocol?
    var router: PasswordRouterInput

    init(view: PasswordViewProtocol, router: PasswordRouterInput) {
        self.view = view
        self.router = router
    }
}

extension PasswordPresenter: PasswordPresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
