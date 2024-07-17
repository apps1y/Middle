//
//  HomePresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class HomePresenter {
    weak var view: HomeViewProtocol?
    var router: HomeRouterInput
    
    private let networkService: NetworkMainServiceProtocol
    private let databasePreviewsManager: DatabasePreviewsProtocol

    init(view: HomeViewProtocol?, router: HomeRouterInput, networkService: NetworkMainServiceProtocol, databasePreviewsManager: DatabasePreviewsProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.databasePreviewsManager = databasePreviewsManager
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
}
