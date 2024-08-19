//
//  PostCommentViewModel.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation

protocol IPostCommentViewModel {
    var onShowAllComments: (([PostCommentEntity]) -> ())? {get set}
    func getCommentList()
}

class PostCommentViewModel: IPostCommentViewModel {
    private var usecase: IPostCommentUseCase
    init(usecase: IPostCommentUseCase) {
        self.usecase = usecase
    }
    
    var onShowAllComments: (([PostCommentEntity]) -> ())?
    func getCommentList() {
        usecase.getCommentsMapper {[weak self] comments in
            self?.onShowAllComments?(comments)
        }
    }
}