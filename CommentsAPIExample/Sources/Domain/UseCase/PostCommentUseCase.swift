//
//  PostCommentUseCase.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation
import Combine

protocol IPostCommentUseCase {
    var commentListPublisher: Published<[PostCommentEntity]>.Publisher {get}
    func getCommentsMapper()
}

class PostCommentUseCase: IPostCommentUseCase {
    private var cancellables = Set<AnyCancellable>()
    private var repository: IPostCommentRepository
    
    init(repository: IPostCommentRepository) {
        self.repository = repository
    }
    
    var commentListPublisher: Published<[PostCommentEntity]>.Publisher {
        $commentList
    }
    
    @Published var commentList: [PostCommentEntity] = []
    
    func getCommentsMapper(){
        repository.getCommentsResult()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Get list Error: \(error)")
                case .finished:
                    print("Get list Success")
                }
            } receiveValue: {[weak self] response in
                let mapperData = response.map { cmt -> PostCommentEntity in
                        .init(id: cmt.id, name: cmt.name, email: cmt.email, comment: cmt.body)
                }
                self?.commentList = mapperData
                
            }
            .store(in: &cancellables)
    }
}

