//
//  PostCommentRepository.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation
import Combine

protocol IPostCommentRepository {
    func getCommentsResult() -> AnyPublisher<[PostCommentResponse], APIError>
    func deleteCommentById(request: DeleteCommentParamRequest) -> AnyPublisher<DeleteCommentResponse, APIError>
}

class PostCommentRepository: IPostCommentRepository {
    private var networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func getCommentsResult() -> AnyPublisher<[PostCommentResponse], APIError> {
        return networkManager.fetchDatas(endPoint: NetworkEndpoint.getComments.path, method: .get, paramRequest: PostCommentParamRequest())
    }
    
    func deleteCommentById(request: DeleteCommentParamRequest) -> AnyPublisher<DeleteCommentResponse, APIError> {
        return networkManager.fetchDatas(endPoint: NetworkEndpoint.deleteComment(id: request.id).path, method: .delete, paramRequest: request)
    }
}
