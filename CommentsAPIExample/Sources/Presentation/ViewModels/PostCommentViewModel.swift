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
    var onRemoveSuccess: (() -> ())? {get set}
    func getCommentList()
    func deleteCommentById(row: Int)
}

class PostCommentViewModel: IPostCommentViewModel {
    private var cancellables = Set<AnyCancellable>()
    private var getUsecase: IPostCommentUseCase
    private var deleteUsecase: IDeleteCommentUseCase
    init(getUsecase: IPostCommentUseCase, deleteUsecase: IDeleteCommentUseCase) {
        self.getUsecase = getUsecase
        self.deleteUsecase = deleteUsecase
        bind()
    }
    
    @Published var comments: [PostCommentEntity] = []
    var onShowAllComments: (([PostCommentEntity]) -> ())?
    var onRemoveSuccess: (() -> ())?
    
    private func bind() {
        getUsecase.commentListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] comments in
                self?.comments = comments
                self?.onShowAllComments?(comments)
            }
            .store(in: &cancellables)
    }
    
    func getCommentList() {
        getUsecase.getCommentsMapper()
    }
    
    private func getIdByRow(row: Int) -> Int {
        comments[row].id
    }
    
    func deleteCommentById(row: Int) {
        let idParamRquest = getIdByRow(row: row)
        Task {
            do {
                try await deleteUsecase.deleteCommentById(id: idParamRquest)
                self.comments.remove(at: row)
                self.onShowAllComments?(self.comments)
                self.onRemoveSuccess?()
                print("Successfully removed from the ViewModel layer!")
                print("Row: \(row), ID: \(idParamRquest)")
            } catch {
                print("Removal from the ViewModel layer failed with an error: \(error)")
            }
        }
    }
}
