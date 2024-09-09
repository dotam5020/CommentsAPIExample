//
//  GetCommentListUseCase.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation
import Combine

protocol IGetCommentListUseCase {
    func getCommentsMapper() async throws -> [CommentListEntity]
    
}

class GetCommentListUseCase: IGetCommentListUseCase {
    private var cancellables = Set<AnyCancellable>()
    private var repository: IPageCommentsRepository
    
    init(repository: IPageCommentsRepository) {
        self.repository = repository
    }
    
    func getCommentsMapper() async throws -> [CommentListEntity] {
        return try await withCheckedThrowingContinuation { continuation in
            repository.getCommentsResult()
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .finished:
                        break
                    }
                } receiveValue: { response in
                    let mapperData = response.map { comment -> CommentListEntity in
                            .init(id: comment.id, name: comment.name, email: comment.email, comment: comment.body)
                    }
                    continuation.resume(returning: mapperData)
                }
                .store(in: &cancellables)

        }
    }
}

