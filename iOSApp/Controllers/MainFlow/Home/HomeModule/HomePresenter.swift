//
//  HomePresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func warning(message: String)
}

final class HomePresenter {
    weak var view: HomeViewProtocol?
    var router: HomeRouterInput
    
    private let networkService: NetworkProfileProtocol
    private let coreDataService: CoreDataProtocol

    init(view: HomeViewProtocol?, router: HomeRouterInput, networkService: NetworkProfileProtocol, coreDataService: CoreDataProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
    
    func warning(message: String) {
        router.presentWarningAlert(message: message)
    }
}
