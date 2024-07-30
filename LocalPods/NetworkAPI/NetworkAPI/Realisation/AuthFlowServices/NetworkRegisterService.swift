//
//  NetworkRegisterService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

extension NetworkService: NetworkRegisterProtocol {
    
    public func checkEmail(email: String, completion: @escaping (NResult<None>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/auth/check-email", headers: [:], httpMethod: .post)
        let requestModel = CheckEmailRequestModel(email: email)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<None>, NetworkRequestError>) in
            let nresult = StatusValidation.validate(result: result)
            completion(nresult)
        }
    }
    
    public func register(email: String, password: String, 
                         completion: @escaping (NResult<RegisterResponseModel>) -> Void) {
        
        let request = NetworkRequest(stringURL: "/api/auth/register", headers: [:], httpMethod: .post)
        let requestModel = RegisterRequestModel(email: email, password: password)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<RegisterResponseModel>, NetworkRequestError>) in
            let nresult = StatusValidation.validate(result: result)
            completion(nresult)
        }
        
    }
}
