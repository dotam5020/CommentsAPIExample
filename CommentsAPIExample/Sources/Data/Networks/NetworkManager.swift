//
//  NetworkManager.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    func fetchDatas<T: Codable, E: Codable>(endPoint: String, method: EMethodRequest, paramRequest: E?) -> AnyPublisher<T, APIError>{
        guard let url = URL(string: "\(NetworkConstant.shared.baseURL)\(endPoint)") else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        print("Request URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let paramRequest = paramRequest {
            do {
                request.httpBody = try JSONEncoder().encode(paramRequest)
                request.addValue(EParameterEncoder.value.rawValue, forHTTPHeaderField: EParameterEncoder.field.rawValue)
            } catch {
                return Fail(error: APIError.decodingError).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.invalidResponse
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if let apiErr = error as? APIError {
                    return apiErr
                } else {
                    return APIError.decodingError
                }
                
            }
            .eraseToAnyPublisher()
    }
}

