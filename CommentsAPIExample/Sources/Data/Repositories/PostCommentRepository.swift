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
}

class PostCommentRepository: IPostCommentRepository {
    private var networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func getCommentsResult() -> AnyPublisher<[PostCommentResponse], APIError> {
       return networkManager.fetchDatas(endPoint: NetworkEndpoint.comments.rawValue, method: .get, paramRequest: PostCommentParamRequest())
    }
}
