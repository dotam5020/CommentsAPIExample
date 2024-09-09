//
//  PageCommentsResponse.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation

struct GetCommentListResponse: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

struct DeleteCommentResponse: Codable {}