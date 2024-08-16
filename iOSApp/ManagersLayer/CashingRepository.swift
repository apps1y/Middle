//
//  CashingRepository.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 06.08.2024.
//

import Foundation

protocol CashingRepositoryProtocol {
    func fetchUserCash() -> UserModel?
    
    func updateUserCash(user: UserModel)
    
    func clearUserCash()
    
    func fetchTelegramAccountCash() -> [TelegramAccountModel]
    
    func updateTelegramAccountCash(accounts: [TelegramAccountModel])
    
    func clearTelegramAccountCash()
    
    func clearAllCash()
}

class CashingRepository: CashingRepositoryProtocol {
    
    private let userDefaultsManager: UserDefaultsProtocol
    private let coreDataService: CoreDataProtocol
    
    init(userDefaultsManager: UserDefaultsProtocol, coreDataService: CoreDataProtocol) {
        self.userDefaultsManager = userDefaultsManager
        self.coreDataService = coreDataService
    }
    
    func fetchUserCash() -> UserModel? {
        guard let email = userDefaultsManager.fetch(key: "user_email") else { return nil }
        return UserModel(email: email)
    }
    
    func updateUserCash(user: UserModel) {
        userDefaultsManager.set(key: "user_email", object: user.email)
    }
    
    func clearUserCash() {
        userDefaultsManager.delete(key: "user_email")
    }
    
    func fetchTelegramAccountCash() -> [TelegramAccountModel] {
        let accounts = coreDataService.fetch { (account: TelegramAccountStorage) in
            return TelegramAccountModel(name: account.name, phone: account.phone)
        }
        return accounts
    }
    
    func updateTelegramAccountCash(accounts: [TelegramAccountModel]) {
        coreDataService.deleteAll(TelegramAccountStorage.self)
        coreDataService.insert(models: accounts) { (model: TelegramAccountModel, entity: TelegramAccountStorage) in
            entity.name = model.name
            entity.phone = model.phone
        }
    }
    
    func clearTelegramAccountCash() {
        coreDataService.deleteAll(TelegramAccountStorage.self)
    }
    
    func clearAllCash() {
        clearUserCash()
        clearTelegramAccountCash()
    }
}
