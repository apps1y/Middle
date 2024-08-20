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
    func removeTelegramAccount(account: TelegramAccountModel, indexPath: IndexPath)
    
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

// MARK: - private funcs
extension SettingsPresenter {
    
    /// подгрузка и кешрование данных профиля
    private func prepareProfileConfiguration(completion: @escaping () -> Void) {
        view?.startLoadingView()
        networkService.profile(token: bearerToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success200(let data):
                    let user = UserModel(email: data.data.email)
                    self?.user = user
                    self?.view?.show(user: user)
                    self?.cashingRepository.updateUserCash(user: user)
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
    
    /// подгрузка и кеширование добавленных телеграмм аккаунтов
    private func prepareTelegramConfiguration(completion: @escaping () -> Void) {
        view?.startLoadingView()
        networkService.getUserTelegramSessions(token: bearerToken) { [weak self] result in
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
    
    private func removeTelegramAccountRequest(account: TelegramAccountModel) {
        networkService.removeTelegramSession(token: bearerToken, phoneNumber: account.phone) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success200(_):
                    self?.prepareTelegramConfiguration {
                        self?.view?.finishLoadingView()
                    }
                case .unauthorized:
                    self?.cashingRepository.clearAllCash()
                    self?.keychainBearerManager.clearToken()
                    self?.coordinator?.start()
                case .success400(_):
                    self?.view?.append(account: account)
                    self?.prepareProfileConfiguration {
                        self?.view?.finishLoadingView()
                    }
                case .failure(_):
                    self?.view?.append(account: account)
                }
            }
        }
    }
    
    private func fetchTelegramAccountsFromCash() {
        let accountsCash = cashingRepository.fetchTelegramAccountCash()
        view?.show(accounts: accountsCash)
    }
    
    private func fetchUserFromCash() {
        if let user = cashingRepository.fetchUserCash() {
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
        
        print("loaded info request")
        
        fetchUserFromCash()
        fetchTelegramAccountsFromCash()
        
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
            self.isLoadingRequests = false
        }
    }
    
    func changeUserPasswordTapped() {
        guard let user else { return }
        router.pushRepasswordPreview(email: user.email)
    }
    
    func removeTelegramAccount(account: TelegramAccountModel, indexPath: IndexPath) {
        guard !isLoadingRequests else { return }
        
        router.presentLogoutTgSheet { [weak self] in
            self?.view?.startLoadingView()
            self?.view?.removeAcount(at: indexPath)
            self?.removeTelegramAccountRequest(account: account)
        }
    }
    
    func newTelegramAccountTapped() {
        guard !isLoadingRequests else { return }
        
        if cashingRepository.fetchTelegramAccountCash().count < 3{
            router.presentTelegramAddFlow { [weak self] account in
                self?.view?.append(account: account)
                
                self?.prepareTelegramConfiguration {
                    self?.view?.finishLoadingView()
                }
            }
        } else {
            router.presentAccountsLimitAlert()
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
            self?.cashingRepository.clearAllCash()
            self?.keychainBearerManager.clearToken()
            self?.coordinator?.start()
        }
    }
}
