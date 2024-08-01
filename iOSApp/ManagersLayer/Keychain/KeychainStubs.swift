//
//  KeychainStubs.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 01.08.2024.
//

import Foundation

final class KeychainStub {
    private var string: String? = nil
}

extension KeychainStub: KeychainBearerProtocol {
    
    func save(token: String) {
        string = token
    }
    
    func getToken() -> String? {
        string
    }
    
    func clearToken() {
        string = nil
    }
}

extension KeychainStub: KeychainSubscriptionProtocol {
    
}
