//
//  NetworkMainService.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 17.07.2024.
//

import Foundation


protocol NetworkMainServiceProtocol: AnyObject {
    
}

final class NetworkMainService: NetworkService, NetworkMainServiceProtocol {
    private let BearerToken: String
    
    init(BearerToken: String) {
        self.BearerToken = BearerToken
    }
}
