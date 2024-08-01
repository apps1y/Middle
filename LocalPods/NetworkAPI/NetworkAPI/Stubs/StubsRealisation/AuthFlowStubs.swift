//
//  AuthFlowStubs.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 25.07.2024.
//

import Foundation

// MARK: NetworkLoginProtocol stub
extension NetworkServiceStub: NetworkAuthProtocol {
    public func register(email: String, password: String, completion: @escaping (NResult<RegisterResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = RegisterResponseModel(status: "nil", isActive: true, token: "user_token")
            completion(.success200(data: responseModel))
        }
    }
    
    public func login(email: String, password: String, completion: @escaping (NResult<LoginResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = LoginResponseModel(confirmed: true, status: "", token: "stubs_token")
            completion(.success200(data: responseModel))
        }
    }
}

extension NetworkServiceStub: NetworkRecoverProtocol {
    public func sendCode(email: String, completion: @escaping (NResult<None>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = None(status: "nil")
            completion(.success200(data: responseModel))
        }
    }
    
    public func confirmResert(email: String, code: String, completion: @escaping (NResult<ConfirmResertResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = ConfirmResertResponseModel(status: "nil", token: "stubs_token", confirmed: true)
            completion(.success200(data: responseModel))
        }
    }
    
    public func updatePassword(token: String, password: String, completion: @escaping (NResult<UpdatePasswordResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = UpdatePasswordResponseModel(status: "nil", token: "stubs_token", confirmed: true)
            completion(.success200(data: responseModel))
        }
    }
    
    
}

extension NetworkServiceStub: NetworkValidationProtocol {
    public func validateAccount(token: String, code: String, completion: @escaping (NResult<None>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = None(status: "nil")
            completion(.success200(data: responseModel))
        }
    }
    
    public func checkEmail(email: String, completion: @escaping (NResult<None>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = None(status: "nil")
            completion(.success200(data: responseModel))
        }
    }
    
    
}

