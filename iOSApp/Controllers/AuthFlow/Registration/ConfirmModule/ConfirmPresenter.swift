//
//  ConfirmPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit

protocol ConfirmPresenterProtocol: AnyObject {
    
    /// Подтверждение почты
    /// - Parameters:
    ///   - mail: почта, которую ввели на предыдущем экране
    ///   - code: код подтверждения
    func confirm(mail: String, with code: String)
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
    func confirm(mail: String, with code: String) {
        view?.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.view?.finishLoading(error: nil)
            self?.router.pushPasswordModule()
        }
    }
}
