//
//  CommentViewController.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import UIKit
import SnapKit

class CommentViewController: BaseViewController {
    var viewModel: IPostCommentViewModel = PostCommentViewModel(usecase: PostCommentUseCase(repository: PostCommentRepository(networkManager: NetworkManager.shared)))
    var tableViewEvent: ICommentTableView = CommentTableView()
    
    private lazy var tblView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        self.title = "All comments on page 1"
        [tblView].forEach {view.addSubview($0)}
        
        tblView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func bindData() {
        viewModel.getCommentList()
        viewModel.onShowAllComments = {[weak self] cmts in
            self?.tableViewEvent.updateData(cmts)
        }
    }
    
    override func bindEvent() {
        tableViewEvent.setupTableView(tblView)
        tableViewEvent.onReloadData = {[weak self] in
            self?.tblView.reloadData()
        }
    }
}


