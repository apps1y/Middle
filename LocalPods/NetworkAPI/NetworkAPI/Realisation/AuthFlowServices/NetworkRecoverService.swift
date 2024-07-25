//
//  NetworkRecoverService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

extension NetworkService: NetworkRecoverProtocol {
    public func sendCode(email: String, completion: @escaping (NResult<None>) -> Void) {
        
    }
    
    public func confirmResert(email: String, code: String, completion: @escaping (NResult<ConfirmResertResponseModel>) -> Void) {
        
    }
    
    public func updatePassword(token: String, password: String, completion: @escaping (NResult<None>) -> Void) {
        
    }
    
    
}
