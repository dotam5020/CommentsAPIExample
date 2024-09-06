//
//  NetworkConstant.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation

class NetworkConstant {
    static let shared = NetworkConstant()
    private init() {}
    
    var baseURL: String {
        "https://jsonplaceholder.typicode.com/"
    }
}

enum NetworkEndpoint {
    case getComments
    case deleteComment(id: Int)
    
    var path: String {
        switch self {
        case .getComments:
            return "posts/1/comments"
        case .deleteComment(let id):
            return "comments/\(id)"
        }
    }
}

enum EMethodRequest: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum EParameterEncoder: String {
    case value = "application/json"
    case field = "Content-Type"
}
