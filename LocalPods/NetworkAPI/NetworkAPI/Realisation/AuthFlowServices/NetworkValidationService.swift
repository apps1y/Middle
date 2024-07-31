//
//  NetworkConfirmService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

extension NetworkService: NetworkValidationProtocol {
    public func validateAccount(token: String, code: String, completion: @escaping (NResult<None>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/validate/account", headers: [:], httpMethod: .post, bearer: token)
        let requestModel = ValidateAccountRequestModel(code: code)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<None>, NetworkRequestError>) in
            let nresult = StatusValidation.validate(result: result)
            completion(nresult)
        }
    }
    
    public func checkEmail(email: String, completion: @escaping (NResult<None>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/validate/email", headers: [:], httpMethod: .post)
        let requestModel = CheckEmailRequestModel(email: email)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<None>, NetworkRequestError>) in
            let nresult = StatusValidation.validate(result: result)
            completion(nresult)
        }
    }
}
