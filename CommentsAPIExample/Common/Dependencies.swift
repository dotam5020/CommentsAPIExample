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
    
    static var getCommentsUseCase: IGetCommentListUseCase {
        return shared.resolvedGetCommentsUseCase
    }
    
    static var deleteCommentUseCase: IDeleteCommentUseCase {
        return shared.resolvedDeleteCommentUseCase
    }
    
    
    private lazy var resolvedDeleteCommentUseCase: IDeleteCommentUseCase = {
        return DeleteCommentUseCase(repository: resolvedPageCommentsRepository)
    }()
    
    private lazy var resolvedGetCommentsUseCase: IGetCommentListUseCase = {
        return GetCommentListUseCase(repository: resolvedPageCommentsRepository)
    }()
    
    private lazy var resolvedPageCommentsRepository: IPageCommentsRepository = {
        return PageCommentsRepository(networkManager: NetworkManager.shared)
    }()
}
