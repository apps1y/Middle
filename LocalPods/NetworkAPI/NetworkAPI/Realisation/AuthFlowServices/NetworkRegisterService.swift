//
//  NetworkRegisterService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

extension NetworkService: NetworkRegisterProtocol {
    public func register(email: String, password: String, 
                         completion: @escaping (NResult) -> Void) {
        
        let request = NetworkRequest(stringURL: "/api/auth/register", headers: [:], httpMethod: .post)
        let requestModel = RegisterRequestModel(email: email, password: password)
        
        perform(request: request, requestModel: requestModel) { (result: Result<NetworkResponse<RegisterResponseModel>, 
                                                                 NetworkServiceError>) in
            switch result {
            case .success(let response):
                if response.httpCode == 200, let model = response.data {
                    return completion(.success(model))
                }
                
                switch response.httpCode {
                case 401:
                    return completion(.failure("Неверный пароль"))
                case 404:
                    return completion(.failure("Такого пользователя не существует"))
                default:
                    return completion(.failure("Ошибка"))
                }
                
            case .failure(let error):
                return completion(.failure(error.localizedDescription))
            }
        }
        
    }
}
