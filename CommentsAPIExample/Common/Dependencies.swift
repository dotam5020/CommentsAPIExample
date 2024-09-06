//
//  Dependencies.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 30/08/2024.
//

import Foundation

class Dependencies {
    static let shared = Dependencies()
    private init(){}
    
    static var postCommentUseCase: IPostCommentUseCase {
        return shared.resolvedPostCommentUseCase
    }
    
    static var deleteCommentUseCase: IDeleteCommentUseCase {
        return shared.resolvedDeleteCommentUseCase
    }
    
    
    private lazy var resolvedDeleteCommentUseCase: IDeleteCommentUseCase = {
        return DeleteCommentUseCase(repository: resolvedPostCommentRepository)
    }()
    
    private lazy var resolvedPostCommentUseCase: IPostCommentUseCase = {
        return PostCommentUseCase(repository: resolvedPostCommentRepository)
    }()
    
    private lazy var resolvedPostCommentRepository: IPostCommentRepository = {
        return PostCommentRepository(networkManager: NetworkManager.shared)
    }()
}
