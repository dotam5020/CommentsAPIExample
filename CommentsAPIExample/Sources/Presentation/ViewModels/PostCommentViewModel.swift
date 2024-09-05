//
//  PostCommentViewModel.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation
import Combine

protocol IPostCommentViewModel {
    var onShowAllComments: (([PostCommentEntity]) -> ())? {get set}
    func getCommentList()
}

class PostCommentViewModel: IPostCommentViewModel {
    private var cancellables = Set<AnyCancellable>()
    private var usecase: IPostCommentUseCase
    init(usecase: IPostCommentUseCase) {
        self.usecase = usecase
        bind()
    }
    
    @Published var comments: [PostCommentEntity] = []
    var onShowAllComments: (([PostCommentEntity]) -> ())?
    
    private func bind() {
        usecase.commentListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] comments in
                self?.comments = comments
                self?.onShowAllComments?(comments)
            }
            .store(in: &cancellables)
    }
    
    func getCommentList() {
        usecase.getCommentsMapper()
    }
}
