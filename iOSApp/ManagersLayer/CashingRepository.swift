//
//  CashingRepository.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 06.08.2024.
//

import Foundation

protocol CashingRepositoryProtocol {
    
    /// подгрузка информации о юзере из кэша
    /// - Returns: модель юзера
    func fetchUser() -> UserModel?
    
    /// обновления информации о юзере в кэш
    /// - Parameter user: модель юзера
    func updateUser(user: UserModel)
    
    /// очищает кэш юзера
    func clearUser()
    
    /// очистка всего кэша
    func clearAllCash()
}

class CashingRepository: CashingRepositoryProtocol {
    
    private let userDefaultsManager: UserDefaultsProtocol
    private let coreDataService: CoreDataProtocol
    
    init(userDefaultsManager: UserDefaultsProtocol, coreDataService: CoreDataProtocol) {
        self.userDefaultsManager = userDefaultsManager
        self.coreDataService = coreDataService
    }
    
    func fetchUser() -> UserModel? {
        guard let email = userDefaultsManager.fetch(key: "user_email") else { return nil }
        return UserModel(email: email)
    }
    
    func updateUser(user: UserModel) {
        userDefaultsManager.set(key: "user_email", object: user.email)
    }
    
    func clearUser() {
        userDefaultsManager.delete(key: "user_email")
    }
    
    
    func clearAllCash() {
        clearUser()
    }
}
