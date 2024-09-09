//
//  DeleteCommentUseCase.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 06/09/2024.
//

import Foundation
import Combine


protocol IDeleteCommentUseCase {
    func deleteCommentById(id: Int) async throws
}

class DeleteCommentUseCase: IDeleteCommentUseCase {
    private var cancellables = Set<AnyCancellable>()
    private var repository: IPageCommentsRepository
    
    init(repository: IPageCommentsRepository) {
        self.repository = repository
    }
    
    func deleteCommentById(id: Int) async throws {
        let param = DeleteCommentParamRequest(id: id)
        try await withCheckedThrowingContinuation { continuation in
            repository.deleteCommentById(request: param)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .finished:
                        break
                    }
                    
                } receiveValue: { _ in
                    continuation.resume()
                }
                .store(in: &cancellables)
        }
    }
}
