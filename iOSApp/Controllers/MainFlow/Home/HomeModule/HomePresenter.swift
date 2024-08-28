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
    
    func prepareUnravelViewShowing()
    
}

final class HomePresenter {
    weak var view: HomeViewProtocol?
    var router: HomeRouterInput
    
    private let networkService: NetworkProfileProtocol
    private let cashingRepisitory: CashingRepositoryProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    init(view: HomeViewProtocol?, router: HomeRouterInput, networkService: NetworkProfileProtocol, cashingRepisitory: CashingRepositoryProtocol, keychainBearerManager: KeychainBearerProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.cashingRepisitory = cashingRepisitory
        self.keychainBearerManager = keychainBearerManager
        self.coordinator = coordinator
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    func prepareUnravelViewShowing() {
        router.presentUnravelViewController()
    }
    
    func viewDidLoaded() {
        // first setup view
    }
}
