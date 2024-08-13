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
    
    private let networkService: NetworkMainProtocol & NetworkRecoverProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    private var userEmail: String = "email"

    init(view: SettingsViewProtocol?, router: SettingsRouterInput, networkService: NetworkMainProtocol & NetworkRecoverProtocol, keychainBearerManager: KeychainBearerProtocol, coordinator: FlowCoordinator?) {
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
        router.pushRecoveryFlow(email: userEmail)
    }
    
    func addNewTelegramAccount() {
        router.presentTelegramAddFlow { [weak self] userName in
            self?.view?.add(newAccount: userName)
        }
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
