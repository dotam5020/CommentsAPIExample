//
//  APIError.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 29/08/2024.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case statusCode(Int)
    case unowned
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .invalidResponse:
            return NSLocalizedString("Rsponse Error", comment: "Invalid response")
        case .decodingError:
            return NSLocalizedString("Decoding error", comment: "Decoding error")
        case .statusCode(let code):
            return String(format: NSLocalizedString("Status code: %d", comment: "HTTP status code"), code)
        case .unowned:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
