//
//  SettingsPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import NetworkAPI

protocol SettingsPresenterProtocol: AnyObject {
    /// загрузка view
    func viewDidLoaded()
    
    /// запрос на смену пароля
    func changeUserPasswordTapped()
    
    /// удаление телеграм аккаунта
    func removeTelegramAccount()
    
    /// добавление нового телеграмм аккаунта
    func newTelegramAccountTapped()
    
    /// показ экрана с подпиской
    func subscribtionTapped()
    
    /// показ прав конфеденциальности
    func rulesOfConfidentialTapped()
    
    /// оценить в AppStrore
    func writeReviewTapped()
    
    /// поделиться с друзьями
    func shareWithFriendsTapped()
    
    /// выйти из приложения
    func logoutUserTapped()
}

final class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterInput
    
    private let networkService: NetworkTelegramProtocol & NetworkRecoverProtocol & NetworkProfileProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    private var user: UserModel?

    init(view: SettingsViewProtocol?, router: SettingsRouterInput, 
         networkService: NetworkTelegramProtocol & NetworkRecoverProtocol & NetworkProfileProtocol,
         keychainBearerManager: KeychainBearerProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.coordinator = coordinator
    }
    
    private func requestToChangeUserPassword() {
        guard let user else { return }
        view?.startLoadingChangePasswordCell()
        networkService.sendCode(email: user.email) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.finishLoadingChangePasswordCell()
                switch result {
                case .success200(_):
                    self?.router.pushChangePasswordView(email: user.email)
                case .success400(let status):
                    self?.router.presentWarningAlert(message: status.localizedDescription)
                case .failure(let error):
                    self?.router.presentWarningAlert(message: error)
                }
            }
        }
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func viewDidLoaded() {
        // request to cash
        // and request to load data
        // request to user information
        user = UserModel(email: "ivanicloud_vanya@icloud.com")
    }
    
    func changeUserPasswordTapped() {
        router.presentChangePasswordAlert { [weak self] in
            self?.requestToChangeUserPassword()
        }
    }
    
    func removeTelegramAccount() {
        router.presentLogoutTgSheet {
            print("logout tg")
        }
    }
    
    func newTelegramAccountTapped() {
        
    }
    
    func subscribtionTapped() {
        
    }
    
    func rulesOfConfidentialTapped() {
        
    }
    
    func writeReviewTapped() {
        
    }
    
    func shareWithFriendsTapped() {
        
    }
    
    func logoutUserTapped() {
        router.presentLogoutAppAlert { [weak self] in
            self?.keychainBearerManager.clearToken()
            self?.coordinator?.start()
        }
    }
}
