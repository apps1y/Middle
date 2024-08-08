//
//  SettingsPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

protocol SettingsPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func changePassword()
    
    func addNewTelegramAccount()
    
    func openSubscribeInformation()
    
    func openConfidentional()
    
    func ratingApp()
    
    func shareWithFriends()
    
    func logoutAccount()
}

final class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterInput
    
    private let networkService: NetworkMainProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?

    init(view: SettingsViewProtocol?, router: SettingsRouterInput, networkService: NetworkMainProtocol, keychainBearerManager: KeychainBearerProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.coordinator = coordinator
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func viewDidLoaded() {
        // first setup view
    }
    
    func changePassword() {
        // realisation
    }
    
    func addNewTelegramAccount() {
        // realisation
    }
    
    func openSubscribeInformation() {
        // realisation
    }
    
    func openConfidentional() {
        // realisation
    }
    
    func ratingApp() {
        // realisation
    }
    
    func shareWithFriends() {
        // realisation
    }
    
    func logoutAccount() {
        keychainBearerManager.clearToken()
        coordinator?.start()
    }
}
