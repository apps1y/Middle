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
    
    private let networkService: NetworkTelegramProtocol & NetworkProfileProtocol
    private let keychainBearerManager: KeychainBearerProtocol
    private let cashingRepository: CashingRepositoryProtocol
    
    /// app coordinator
    weak var coordinator: FlowCoordinator?
    
    private var user: UserModel?

    init(view: SettingsViewProtocol?, router: SettingsRouterInput, networkService: NetworkTelegramProtocol & NetworkProfileProtocol, keychainBearerManager: KeychainBearerProtocol, cashingRepository: CashingRepositoryProtocol, coordinator: FlowCoordinator?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.keychainBearerManager = keychainBearerManager
        self.cashingRepository = cashingRepository
        self.coordinator = coordinator
    }
}

// MARK: - private funcs
extension SettingsPresenter {
    
    /// подгрузка и кешрование данных профиля
    private func prepareProfileConfiguration(completion: @escaping () -> Void) {
        if let user = cashingRepository.fetchUserCash() {
            view?.show(user: user)
        }
        
        guard let token = keychainBearerManager.getToken() else {
            coordinator?.start()
            return completion()
        }
        view?.startLoadingView()
        networkService.profile(token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success200(let data):
                    let user = UserModel(email: data.data.email)
                    self?.view?.show(user: user)
                    self?.cashingRepository.updateUserCash(user: user)
                case .unauthorized:
                    self?.cashingRepository.clearAllCash()
                    self?.keychainBearerManager.clearToken()
                    self?.coordinator?.start()
                case .success400(_): break
                case .failure(_): break
                }
                completion()
            }
        }
    }
    
    /// подгрузка и кеширование добавленных телеграмм аккаунтов
    private func prepareTelegramConfiguration(completion: @escaping () -> Void) {
        
        let accountsCash = cashingRepository.fetchTelegramAccountCash()
        view?.show(accounts: accountsCash)
        
        
        guard let token = keychainBearerManager.getToken() else {
            coordinator?.start()
            return completion()
        }
        view?.startLoadingView()
        networkService.getUserTelegramSessions(token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success200(let data):
                    let accounts: [TelegramAccountModel] = data.sessions.map { TelegramAccountModel(name: $0.name, phone: $0.phone) }
                    self?.view?.show(accounts: accounts)
                    self?.cashingRepository.updateTelegramAccountCash(accounts: accounts)
                case .unauthorized:
                    self?.cashingRepository.clearAllCash()
                    self?.keychainBearerManager.clearToken()
                    self?.coordinator?.start()
                case .success400(_): break
                case .failure(_): break
                }
                completion()
            }
        }
    }
}


// MARK: - SettingsPresenterProtocol realisation
extension SettingsPresenter: SettingsPresenterProtocol {
    func viewDidLoaded() {
        let group = DispatchGroup()
        
        group.enter()
        prepareProfileConfiguration {
            group.leave()
        }
        
        group.enter()
        prepareTelegramConfiguration {
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.view?.finishLoadingView()
        }
    }
    
    func changeUserPasswordTapped() {
        guard let user else { return }
        router.pushRepasswordPreview(email: user.email)
    }
    
    func removeTelegramAccount() {
        router.presentLogoutTgSheet {
            print("logout tg")
        }
    }
    
    func newTelegramAccountTapped() {
        router.presentTelegramAddFlow { telegramAccount in
            // возвращение добавленного телеграмм аккаунта
        }
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
