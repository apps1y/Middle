//
//  NetworkService.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

// MARK: Потоки
/// все запросы приходят не в main потоке
/// в этом фреймворке отсутствует перенаправление на осносной поток
/// это нужно делать при обращении в контроллере

public final class NetworkService {
    
    public init() {}
    
    private let session = URLSession.shared
    
    /// совершение запроса
    /// - Parameters:
    ///   - request: запрос на сервер в виде модели NetworkRequest
    ///   - requestModel: моделька для отправления запроса (опционально)
    ///   - responseModel: моделька для парсинга
    ///   - completion: блок с возвращением модели или ошибки
    func perform<RequestModel: Encodable, ResponseModel: Decodable>(request: NetworkRequest, requestModel: RequestModel?, completion: @escaping (Result<NetworkResponse<ResponseModel>, NetworkServiceError>) -> Void) {
        
        guard var urlComponents = URLComponents(string: request.stringURL) else {
            return completion(.failure(.invalidURL))
        }
        /// заголовки для запроса
        urlComponents.queryItems = request.headers.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        /// url из компонентов
        guard let url = urlComponents.url else {
            return completion(.failure(.invalidURL))
        }
        
        var urlRequest = URLRequest(url: url)
        /// метод запроса
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        /// добавление bearer токена
        if let token = request.bearer {
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        }
        
        /// добавление тела запроса
        if let requestModel {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(requestModel)
            } catch {
                return completion(.failure(.encodingError(error: error)))
            }
        }
        
        /// создание таски
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                return completion(.failure(.unknown(error: error)))
            }
            
            guard let data = data else {
                let responseModel = NetworkResponse<ResponseModel>(httpCode: (response as? HTTPURLResponse)?.statusCode ?? -1,
                                                    data: nil)
                return completion(.success(responseModel))
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                let responseModel = NetworkResponse<ResponseModel>(httpCode: (response as? HTTPURLResponse)?.statusCode ?? -1,
                                                    data: nil)
                return completion(.success(responseModel))
            }
            
            do {
                let model = try JSONDecoder().decode(ResponseModel.self, from: data)
                let responseModel = NetworkResponse(httpCode: (response as? HTTPURLResponse)?.statusCode ?? -1,
                                                    data: model)
                return completion(.success(responseModel))
            } catch {
                completion(.failure(.parsingError(error: error)))
            }
        }
        
        task.resume()
    }
}
