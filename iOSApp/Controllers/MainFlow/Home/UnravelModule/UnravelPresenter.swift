//
//  UnravelPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.08.2024
//

import UIKit

protocol UnravelPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class UnravelPresenter {
    weak var view: UnravelViewProtocol?
    var router: UnravelRouterInput

    init(view: UnravelViewProtocol, router: UnravelRouterInput) {
        self.view = view
        self.router = router
    }
}

extension UnravelPresenter: UnravelPresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
