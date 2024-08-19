//
//  PostCommentRepository.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation

typealias PostCommentsResult = Result<[PostCommentResponse], APIError>
protocol IPostCommentRepository {
    func getCommentsResult(_ completion: @escaping(PostCommentsResult) -> ())
}

class PostCommentRepository: IPostCommentRepository {
    private var networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func getCommentsResult(_ completion: @escaping (PostCommentsResult) -> ()) {
        networkManager.requestAPI { (result: PostCommentsResult) in
            completion(result)
        }
    }
}
