//
//  CommentViewController.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import UIKit
import SnapKit
import Combine

class CommentViewController: BaseViewController {
    var viewModel: IPostCommentViewModel = PostCommentViewModel(getUsecase: Dependencies.postCommentUseCase, deleteUsecase: Dependencies.deleteCommentUseCase)
    var tableViewEvent: ICommentTableView = CommentTableView()
    
    private lazy var tblView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCommentList()
        tableViewEvent.setupTableView(tblView)
    }
    
    override func setupUI() {
        self.title = "All comments on page 1"
        [tblView].forEach {view.addSubview($0)}
        
        tblView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func bindData() {
        viewModel.onShowAllComments = {[weak self] cmts in
            guard let self = self else {return}
            self.tableViewEvent.updateData(cmts)
        }
        
        viewModel.onRemoveSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        }
    }
    
    override func bindEvent() {
        tableViewEvent.setupTableView(tblView)
        tableViewEvent.onReloadData = {[weak self] in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        }
        
        tableViewEvent.onDeleteRow = {[weak self] row in
            self?.viewModel.deleteCommentById(row: row)
        }
    }
}


