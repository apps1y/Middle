//
//  NetworkConfirmService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

extension NetworkService: NetworkConfirmProtocol {
    public func confirm(token: String, code: String, completion: @escaping (NResult<None>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/auth/confirm", headers: [:], httpMethod: .post, bearer: token)
        let requestModel = ConfirmRequestModel(code: code)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<None>, NetworkRequestError>) in
            let nresult = StatusValidation.validate(result: result)
            completion(nresult)
        }
    }
}
