//
//  NetworkLoginService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

extension NetworkService: NetworkLoginProtocol {
    public func login(email: String, password: String,
                      completion: @escaping (NResult<LoginResponseModel>) -> Void) {
        
        let request = NetworkRequest(stringURL: "/api/auth/login", headers: [:], httpMethod: .post)
        let requestModel = LoginRequestModel(email: email, password: password)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<LoginResponseModel>, NetworkRequestError>) in
            let nresult = StatusValidation.validate(result: result)
            completion(nresult)
        }
    }
}
