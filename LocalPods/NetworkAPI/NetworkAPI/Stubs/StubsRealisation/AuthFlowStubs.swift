//
//  AuthFlowStubs.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 25.07.2024.
//

import Foundation

// MARK: NetworkLoginProtocol stub
extension NetworkServiceStub: NetworkLoginProtocol {
    public func login(email: String, password: String, completion: @escaping (NResult<LoginResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = LoginResponseModel(confirmed: true, status: "", token: "stubs_token")
            completion(.success200(data: responseModel))
        }
    }
}


// MARK: NetworkRegisterProtocol stub
extension NetworkServiceStub: NetworkRegisterProtocol {
    
    public func checkEmail(email: String, completion: @escaping (NResult<None>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // let responseModel = AuthNone(status: "")
            // completion(.success200(data: responseModel))
        }
    }
    
    public func register(email: String, password: String, completion: @escaping (NResult<RegisterResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // let responseModel = RegisterResponseModel(isActive: false, token: "stubs_token")
            // completion(.success(data: responseModel, httpCode: 200))
        }
    }
}


// MARK: NetworkRecoverProtocol stub
extension NetworkServiceStub: NetworkRecoverProtocol {
    public func updatePassword(token: String, password: String,
                               completion: @escaping (NResult<UpdatePasswordResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // completion(.success(data: nil, httpCode: 200))
        }
    }
    
    public func confirmResert(email: String, code: String, completion: @escaping (NResult<ConfirmResertResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // let responseModel = ConfirmResertResponseModel(token: "stubs_token")
            // completion(.success(data: responseModel, httpCode: 200))
        }
    }
    
    public func sendCode(email: String, completion: @escaping (NResult<None>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // completion(.success(data: nil, httpCode: 200))
        }
    }
}


// MARK: NetworkConfirmProtocol stub
extension NetworkServiceStub: NetworkConfirmProtocol {
    public func confirm(token: String, code: String, completion: @escaping (NResult<None>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // completion(.success(data: nil, httpCode: 200))
        }
    }
}
