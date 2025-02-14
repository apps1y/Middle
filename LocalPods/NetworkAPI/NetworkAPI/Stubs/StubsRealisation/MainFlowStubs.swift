//
//  MainFlowStubs.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 25.07.2024.
//

import Foundation

extension NetworkServiceStub: NetworkProfileProtocol {
    public func profile(token: String, completion: @escaping (CompleteResult<ProfileResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let responseModel = ProfileResponseModel(status: "",
                                                     data: ProfileResponseModel.ProfoleData(confirmed: true,
                                                                                            created_at: "18.01",
                                                                                            email: "vanya@mail.com",
                                                                                            updated_at: ""))
            completion(.success200(data: responseModel))
        }
    }
}

extension NetworkServiceStub: NetworkTelegramProtocol {
    public func getUserTelegramSessions(token: String, completion: @escaping (CompleteResult<UserSessionsResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let sessions: [UserTelegramSession] = [
                UserTelegramSession(name: "Иван", phone: "+79254144498"),
                UserTelegramSession(name: "Карим", phone: "+7800")
            ]
            let responseModel = UserSessionsResponseModel(sessions: sessions, status: "")
            completion(.success200(data: responseModel))
        }
    }
    
    public func addTelegramAccount(token: String, code: String, password: String, phoneNumber: String, completion: @escaping (CompleteResult<UserSessionResponseModel>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = UserSessionResponseModel(
                session: UserTelegramSession(name: "Артем", phone: "+9996623456"),
                status: "SUCCESS"
            )
            completion(.success200(data: responseModel))
        }
    }
    
    public func removeTelegramSession(token: String, phoneNumber: String, completion: @escaping (CompleteResult<None>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = None(status: "")
            completion(.success200(data: responseModel))
        }
    }
    
    public func sendTelegramCode(token: String, phoneNumber: String, completion: @escaping (CompleteResult<None>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let responseModel = None(status: "")
            completion(.success200(data: responseModel))
        }
    }
}
