//
//  PostCommentUseCase.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation
struct PostCommentModel {
    var name: String
    var email: String
    var comment: String
}

protocol IPostCommentUseCase {
    func getCommentsMapper(completed: @escaping([PostCommentModel]) -> ())
}

class PostCommentUseCase: IPostCommentUseCase {
    private var repository: IPostCommentRepository
    
    init(repository: IPostCommentRepository) {
        self.repository = repository
    }
    
    func getCommentsMapper(completed: @escaping ([PostCommentModel]) -> ()) {
        var commentList: [PostCommentModel] = []
        repository.getCommentsResult { (result: PostCommentsResult) in
            switch result {
            case .success(let comments):
                commentList.append(contentsOf: comments.map({ element -> PostCommentModel in
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

