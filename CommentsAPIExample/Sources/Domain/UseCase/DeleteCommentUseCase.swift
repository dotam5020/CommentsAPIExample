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
    private var repository: IPostCommentRepository
    
    init(repository: IPostCommentRepository) {
        self.repository = repository
    }
    
//    func deleteCommentById(id: Int) {
//        let param = DeleteCommentParamRequest(id: id)
//        repository.deleteCommentById(request: param)
//            .map { _ in
//                self.deleteCommentResult = true
//                return true
//            }
//            .catch { _ in
//                Just(false).setFailureType(to: APIError.self)
//            }
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print("Delete failed with error: \(error)")
//                case .finished:
//                    print("Delete finished successfully.")
//                }
//            }, receiveValue: { _ in
//            })
//            .store(in: &cancellables)
//    }
    func deleteCommentById(id: Int) async throws {
        let param = DeleteCommentParamRequest(id: id)
        do {
            try await withCheckedThrowingContinuation { continuation in
                repository.deleteCommentById(request: param)
                    .sink { completion in
                        switch completion {
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        case .finished:
                            break
                        }
                        
                    } receiveValue: { response in
                        continuation.resume(returning: response)
                    }
                    .store(in: &cancellables)
            }
            print("Successfully removed from the UseCase layer!")
        } catch {
            print("Failed to remove from the UseCase layer!")
        }
    }
}
