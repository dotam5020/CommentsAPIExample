//
//  PageCommentsRepository.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation
import Combine

protocol IPageCommentsRepository {
    func getCommentsResult() -> AnyPublisher<[GetCommentListResponse], APIError>
    func deleteCommentById(request: DeleteCommentParamRequest) -> AnyPublisher<DeleteCommentResponse, APIError>
}

class PageCommentsRepository: IPageCommentsRepository {
    private var networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func getCommentsResult() -> AnyPublisher<[GetCommentListResponse], APIError> {
        return networkManager.fetchDatas(endPoint: NetworkEndpoint.getComments.path, method: .get, paramRequest: GetCommentListParamRequest())
    }
    
    func deleteCommentById(request: DeleteCommentParamRequest) -> AnyPublisher<DeleteCommentResponse, APIError> {
        return networkManager.fetchDatas(endPoint: NetworkEndpoint.deleteComment(id: request.id).path, method: .delete, paramRequest: request)
    }
}
