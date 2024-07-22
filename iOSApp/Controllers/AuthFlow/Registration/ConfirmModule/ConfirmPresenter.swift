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
    
    private let networkService: NetworkAuthServiceProtocol

    init(view: ConfirmViewProtocol?, router: ConfirmRouterInput, networkService: NetworkAuthServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
}

extension ConfirmPresenter: ConfirmPresenterProtocol {
    func confirm(mail: String, with code: String) {
        view?.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.view?.finishLoading(error: "")
//            self?.router.pushPasswordModule()
        }
    }
}
