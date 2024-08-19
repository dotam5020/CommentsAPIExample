//
//  NetworkManager.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    func requestAPI(_ completion: @escaping(Result<[PostCommentResponse], APIError>) -> ()) {
        guard let url = URL(string: "\(NetworkConstant.shared.baseURL)\(NetworkEndpoint.comments.rawValue)") else {return}
        let params = PostCommentParamRequest().toEncodable()
        
        AF.request(url, method: .get, parameters: params)
            .responseDecodable(of: [PostCommentResponse].self) { response in
                switch response.result {
                case .success(let values):
                    completion(.success(values))
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else {
                        return completion(.failure(.networkError(error)))
                    }
                    completion(.failure(.statusCode(statusCode)))
                }
            }
    }
}


