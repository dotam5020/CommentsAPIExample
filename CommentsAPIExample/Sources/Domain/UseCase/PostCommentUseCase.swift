//
//  PostCommentUseCase.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation

protocol IPostCommentUseCase {
    func getCommentsMapper(completed: @escaping([PostCommentEntity]) -> ())
}

class PostCommentUseCase: IPostCommentUseCase {
    private var repository: IPostCommentRepository
    
    init(repository: IPostCommentRepository) {
        self.repository = repository
    }
    
    func getCommentsMapper(completed: @escaping ([PostCommentEntity]) -> ()) {
        var commentList: [PostCommentEntity] = []
        repository.getCommentsResult { (result: PostCommentsResult) in
            switch result {
            case .success(let comments):
                commentList.append(contentsOf: comments.map({ element -> PostCommentEntity in
                        .init(name: element.name, email: element.email, comment: element.body)
                }))
                completed(commentList)
            case .failure(let error):
                print("API call failed: \(error.localizedDescription)")
                completed(commentList)
            }
        }
    }
}

