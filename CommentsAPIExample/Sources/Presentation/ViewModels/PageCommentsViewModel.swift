//
//  PageCommentsViewModel.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation
import Combine

protocol IPageCommentsViewModel {
    var onShowAllComments: (([CommentListEntity]) -> ())? {get set}
    var onRemoveSuccess: (() -> ())? {get set}
    func getCommentList()
    func deleteCommentById(row: Int)
}

class PageCommentsViewModel: IPageCommentsViewModel {
    private var cancellables = Set<AnyCancellable>()
    private var getUsecase: IGetCommentListUseCase
    private var deleteUsecase: IDeleteCommentUseCase
    init(getUsecase: IGetCommentListUseCase, deleteUsecase: IDeleteCommentUseCase) {
        self.getUsecase = getUsecase
        self.deleteUsecase = deleteUsecase
    }
    
    private var comments: [CommentListEntity] = []
    var onShowAllComments: (([CommentListEntity]) -> ())?
    var onRemoveSuccess: (() -> ())?
    
    func getCommentList() {
        Task {
            do {
                let comments = try await getUsecase.getCommentsMapper()
                self.comments = comments
                self.onShowAllComments?(comments)
                print("get comments success in VM")
            } catch {
                let error = error as! APIError
                print("get comments fail with error: \(error.localizedDescription)")
            }
        }
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
                print("Successfully removed!")
                print("Row: \(row), ID: \(idParamRquest)")
            } catch {
                let error = error as! APIError
                print("Removal failed with an error: \(error.localizedDescription)")
            }
        }
    }
}
