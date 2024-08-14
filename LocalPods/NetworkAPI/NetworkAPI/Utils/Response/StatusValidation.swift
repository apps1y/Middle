//
//  StatusValidation.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 29.07.2024.
//

import Foundation

class StatusValidation {
    
    static func shortResultValidate<ResponseModel: Statusable & Decodable>(result: Result<NetworkResponse<ResponseModel>, NetworkRequestError>) -> ShortResult<ResponseModel> {
        switch result {
        case .success(let response):
            switch response.httpCode {
            case 200:
                if let data = response.data {
                    return .success200(data: data)
                } else {
                    print("StatusValidation/### Error 200: Data nill with status \(response.status)")
                    return .failure(error: "Ошибка на сервере... Чиним!")
                }
            case 400, 401, 404:
                if let status = Status400.string(response.status) {
                    print("StatusValidation \(response.httpCode) with status: \(status.localizedDescription)")
                    return .success400(status: status)
                } else {
                    print("StatusValidation/### Error \(response.httpCode): неизвестный статус \(response.status)")
                    return .failure(error: "Ошибка на сервере... Чиним!")
                }
            case 500:
                print("StatusValidation/### Error 500: \(response.status)")
                return .failure(error: "Ошибка на сервере... Чиним!")
            default:
                print("StatusValidation/### Error \(response.httpCode): unknown httpCode")
                return .failure(error: "Ошибка на сервере... Чиним!")
            }
        case .failure(let error):
            print("StatusValidation/### Local error: \(error.localizedDescription)")
            return .failure(error: "Данные не были отправлены.")
        }
    }
    
    static func completeResultValidate<ResponseModel: Statusable & Decodable>(result: Result<NetworkResponse<ResponseModel>, NetworkRequestError>) -> CompleteResult<ResponseModel> {
        switch result {
        case .success(let response):
            switch response.httpCode {
            case 200:
                if let data = response.data {
                    return .success200(data: data)
                } else {
                    print("StatusValidation/### Error 200: Data nill with status \(response.status)")
                    return .failure(error: "Ошибка на сервере... Чиним!")
                }
            case 400, 404:
                if let status = Status400.string(response.status) {
                    print("StatusValidation \(response.httpCode) with status: \(status.localizedDescription)")
                    return .failure(error: status.localizedDescription)
                } else {
                    print("StatusValidation/### Error \(response.httpCode): неизвестный статус \(response.status)")
                    return .failure(error: "Ошибка на сервере... Чиним!")
                }
            case 401:
                return .unauthorized
            case 500:
                print("StatusValidation/### Error 500: \(response.status)")
                return .failure(error: "Ошибка на сервере... Чиним!")
            default:
                print("StatusValidation/### Error \(response.httpCode): unknown httpCode")
                return .failure(error: "Ошибка на сервере... Чиним!")
            }
        case .failure(let error):
            print("StatusValidation/### Local error: \(error.localizedDescription)")
            return .failure(error: "Проверьте интернет соединение.")
        }
    }
}
