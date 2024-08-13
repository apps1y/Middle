//
//  NetworkProfileService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 13.08.2024.
//

import Foundation

extension NetworkService: NetworkProfileProtocol {
    public func profile(token: String, completion: @escaping (CompleteResult<ProfileResponseModel>) -> Void) {
        let request = NetworkRequest(stringURL: "/api/profile", headers: [:], httpMethod: .get, bearer: token)
        let requestModel: None? = nil
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<ProfileResponseModel>, NetworkRequestError>) in
            let nresult = StatusValidation.completeResultValidate(result: result)
            completion(nresult)
        }
    }
}
