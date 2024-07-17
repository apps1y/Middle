//
//  NetworkService.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 16.07.2024.
//

import UIKit

final class NetworkService {
    
    let session = URLSession.shared
    
    /// модель запроса
    /// - Parameters:
    ///   - request: запрос на сервер в виде модели NetworkRequest
    ///   - completion: блок с возвращением модели или ошибки
    private func perform<Model: Decodable>(request: NetworkRequest, _ completion: @escaping (Result<Model, NetworkServiceError>) -> Void) {
        guard var urlComponents = URLComponents(string: request.stringURL) else {
            return completion(.failure(.invalidURL))
        }
        urlComponents.queryItems = request.queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            return completion(.failure(.invalidURL))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                return completion(.failure(.unknown(error: error)))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                return completion(.success(model))
            } catch {
                completion(.failure(.decodingError(error: error)))
            }
        }
        
        task.resume()
    }
    
}
