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
        return networkManager.fetchDatas(request: GetComments())
    }
    
    func deleteCommentById(request: DeleteCommentParamRequest) -> AnyPublisher<DeleteCommentResponse, APIError> {
        return networkManager.fetchDatas(request: DeleteComment(id: request.id))
    }
}
