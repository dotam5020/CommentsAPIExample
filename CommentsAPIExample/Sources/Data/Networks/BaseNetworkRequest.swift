//
//  BaseNetworkRequest.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 18/09/2024.
//

import Foundation

protocol NetworkRequest {
    associatedtype RequestMethod: Codable
    associatedtype ResponseMethod: Codable
    
    var endPoint: String {get}
    var method: EMethodRequest {get}
    var paramRequest: RequestMethod? {get}
}


struct GetComments: NetworkRequest {
    typealias RequestMethod = GetCommentListParamRequest
    typealias ResponseMethod = [GetCommentListResponse]
    
    var endPoint: String = NetworkEndpoint.getComments.path
    var method: EMethodRequest = .get
    var paramRequest: GetCommentListParamRequest? = GetCommentListParamRequest()
}

struct DeleteComment: NetworkRequest {
    typealias RequestMethod = DeleteCommentParamRequest
    typealias ResponseMethod = DeleteCommentResponse
    let id: Int
    var endPoint: String {
        return NetworkEndpoint.deleteComment(id: id).path
    }
    var method: EMethodRequest = .delete
    var paramRequest: DeleteCommentParamRequest?
    
    init(id: Int) {
        self.id = id
        self.paramRequest = DeleteCommentParamRequest(id: id)
    }
}
