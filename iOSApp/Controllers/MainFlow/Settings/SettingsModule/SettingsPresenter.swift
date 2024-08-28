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
    func prepareChangeUserPassword()
    
    /// показ экрана с подпиской
    func prepareSubscribtionInfo()
    
    /// показ прав конфеденциальности
    func prepareRulesOfConfidential()
    
    /// оценить в AppStrore
    func prepareWriteReview()
    
    /// поделиться с друзьями
    func prepareShareWithFriends()
    
    /// выход из приложения
    func prepareUserLogout()
}

final class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterInput
    
    private let networkService: NetworkTelegramProtocol & NetworkProfileProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let cashingRepository: CashingRepositoryProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    private var user: UserModel?
    private var isLoadingRequests: Bool = false
    
    private lazy var bearerToken: String = {
        if let token = keychainBearerManager.getToken() {
            return token
        }
        cashingRepository.clearAllCash()
        coordinator?.start()
        return ""
    }()

    init(view: SettingsViewProtocol?, router: SettingsRouterInput, networkService: NetworkTelegramProtocol & NetworkProfileProtocol, keychainBearerManager: KeychainBearerProtocol, cashingRepository: CashingRepositoryProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.cashingRepository = cashingRepository
        self.coordinator = coordinator
    }
}

// MARK: - private funcs with requests
extension SettingsPresenter {
    
    /// подгрузка и кешрование данных профиля
    private func loadUserProfileInformation(completion: @escaping () -> Void) {
        view?.startLoading()
        networkService.profile(token: bearerToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success200(let data):
                    let user = UserModel(email: data.data.email)
                    self?.user = user
                    self?.view?.show(user: user)
                    self?.cashingRepository.updateUser(user: user)
                case .unauthorized:
                    self?.cashingRepository.clearAllCash()
                    self?.keychainBearerManager.clearToken()
                    self?.coordinator?.start()
                case .success400(_): print("error prepareProfileConfiguration 1")
                case .failure(_): print("error prepareProfileConfiguration 2")
                }
                completion()
            }
        }
    }
    
    private func fetchUserFromCash() {
        if let user = cashingRepository.fetchUser() {
            view?.show(user: user)
            self.user = user
        }
    }
}


// MARK: - SettingsPresenterProtocol realisation
extension SettingsPresenter: SettingsPresenterProtocol {
    func viewDidLoaded() {
        guard !isLoadingRequests else { return }
        isLoadingRequests = true
        
        fetchUserFromCash()
        
        let group = DispatchGroup()
        
        group.enter()
        loadUserProfileInformation {
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.view?.finishLoading()
            self.isLoadingRequests = false
        }
    }
    
    func prepareChangeUserPassword() {
        guard let user else { return }
        router.pushRepasswordPreview(email: user.email)
    }
    
    func prepareSubscribtionInfo() {
        
    }
    
    func prepareRulesOfConfidential() {
        
    }
    
    func prepareWriteReview() {
        
    }
    
    func prepareShareWithFriends() {
        
    }
    
    func prepareUserLogout() {
        router.presentLogoutAppAlert { [weak self] in
            self?.cashingRepository.clearAllCash()
            self?.keychainBearerManager.clearToken()
            self?.coordinator?.start()
        }
    }
}
