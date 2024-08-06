//
//  NetworkRecoverService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

extension NetworkService: NetworkRecoverProtocol {
    public func sendCode(email: String, completion: @escaping (AuthResult<None>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/recovery/send-code", headers: [:], httpMethod: .post)
        let requestModel = SendCodeRequestModel(email: email)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<None>, NetworkRequestError>) in
            let nresult = StatusValidation.validate(result: result)
            completion(nresult)
        }
    }
    
    public func confirmResert(email: String, code: String, completion: @escaping (AuthResult<ConfirmResertResponseModel>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/recovery/confirm-reset", headers: [:], httpMethod: .post)
        let requestModel = ConfirmResertRequestModel(code: code, email: email)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<ConfirmResertResponseModel>, NetworkRequestError>) in
            let nresult = StatusValidation.validate(result: result)
            completion(nresult)
        }
    }
    
    public func updatePassword(token: String, password: String,
                               completion: @escaping (AuthResult<UpdatePasswordResponseModel>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/recovery/update-password", headers: [:], httpMethod: .post, bearer: token)
        let requestModel = UpdatePasswordRequestModel(password: password)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<UpdatePasswordResponseModel>, NetworkRequestError>) in
            let nresult = StatusValidation.validate(result: result)
            completion(nresult)
        }
    }
    
    
}
