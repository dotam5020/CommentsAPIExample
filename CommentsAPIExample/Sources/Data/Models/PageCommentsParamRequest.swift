//
//  PageCommentsParamRequest.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation

struct GetCommentListParamRequest: Codable {}

struct DeleteCommentParamRequest: Codable {
    let id: Int
}
