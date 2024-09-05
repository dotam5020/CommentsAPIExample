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

enum NetworkEndpoint: String {
    case comments = "posts/1/comments"
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
