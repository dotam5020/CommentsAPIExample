//
//  BaseModel.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case decodingError
    case networkError(Error)
    case statusCode(Int)
}
