//
//  NetworkTelegramService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 13.08.2024.
//

import Foundation

extension NetworkService: NetworkTelegramProtocol {
    public func getUserTelegramSessions(token: String, completion: @escaping (CompleteResult<UserSessionsResponseModel>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/telegram", headers: [:], httpMethod: .get, bearer: token)
        let requestModel: None? = nil
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<UserSessionsResponseModel>, NetworkRequestError>) in
            let nresult = StatusValidation.completeResultValidate(result: result)
            completion(nresult)
        }
    }
    
    public func addTelegramAccount(token: String, code: String, password: String, phoneNumber: String, completion: @escaping (CompleteResult<None>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/telegram", headers: [:], httpMethod: .post, bearer: token)
        let requestModel = TelegramRequestModel(code: code, password: password, phone_number: phoneNumber)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<None>, NetworkRequestError>) in
            let nresult = StatusValidation.completeResultValidate(result: result)
            completion(nresult)
        }
    }
    
    public func removeTelegramSession(token: String, phoneNumber: String, completion: @escaping (CompleteResult<None>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/telegram", headers: [:], httpMethod: .delete, bearer: token)
        let requestModel = TelegramRequestModel(code: "", password: "", phone_number: phoneNumber)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<None>, NetworkRequestError>) in
            let nresult = StatusValidation.completeResultValidate(result: result)
            completion(nresult)
        }
    }
    
    public func sendTelegramCode(token: String, phoneNumber: String, completion: @escaping (CompleteResult<None>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/telegram/code", headers: [:], httpMethod: .post, bearer: token)
        let requestModel = TelegramRequestModel(code: "", password: "", phone_number: phoneNumber)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<None>, NetworkRequestError>) in
            let nresult = StatusValidation.completeResultValidate(result: result)
            completion(nresult)
        }
    }
    
    
}
