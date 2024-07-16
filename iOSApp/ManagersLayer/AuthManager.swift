//
//  AuthManager.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 16.07.2024.
//

import Foundation

enum AuthStatus {
    case auth
    case notAuth
}

final class AuthManager {
    
    private let keychainManager: KeychainBearerProtocol
    private var status: AuthStatus = .notAuth

    init(keychainManager: KeychainBearerProtocol) {
        self.keychainManager = keychainManager
        
        checkAuth()
    }
    
    private func checkAuth() {
        if keychainManager.getKey() != nil {
            print(status)
            status = .auth
        } else {
            print("no status")
            status = .notAuth
        }
    }
    
    public func getStatus() -> AuthStatus {
        return status
    }
    
    public func changeStatus(_ newStatus: AuthStatus, token: String? = nil) {
        switch newStatus {
        case .auth:
            if let token = token {
                keychainManager.saveKey(token)
                status = newStatus
                print(newStatus)
            } else {
                print("error AuthManager save key")
            }
        case .notAuth:
            keychainManager.clearKey()
            status = newStatus
        }
    }
}
