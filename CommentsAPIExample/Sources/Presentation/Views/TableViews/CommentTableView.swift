//
//  CommentTableView.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import UIKit

protocol ICommentTableView {
    var onReloadData: (() -> ())? {get set}
    func setupTableView(_ tableView: UITableView)
    func updateData(_ comments: [PostCommentEntity])
}

class CommentTableView: NSObject, ICommentTableView, UITableViewDataSource {
    var onReloadData: (() -> ())?
    private var comments: [PostCommentEntity] = []
    
    func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
    }
    
    func updateData(_ comments: [PostCommentEntity]) {
        self.comments = comments
        onReloadData?()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath)
        guard let cell = cell as? CommentCell else {return cell}
        cell.model = model
        return cell
    }
}

class CommentCell: UITableViewCell {
    static let identifier: String = String(describing: CommentCell.self)
    private var _model: PostCommentEntity!
    var model: PostCommentEntity {
        get {
            return _model
        } set {
            _model = newValue
            lblEmail.text = newValue.email
            lblContent.text = newValue.comment
        }
    }
    
    private lazy var lblEmail: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    private lazy var lblContent: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var viewLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .lightGray
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareUI()
    }
    
    private func prepareUI() {
        [lblEmail, lblContent, viewLine].forEach {contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            lblEmail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            lblEmail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            lblEmail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            lblContent.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 8),
            lblContent.leadingAnchor.constraint(equalTo: lblEmail.leadingAnchor),
            lblContent.trailingAnchor.constraint(equalTo: lblEmail.trailingAnchor),
            
            
            viewLine.topAnchor.constraint(equalTo: lblContent.bottomAnchor, constant: 8),
            viewLine.leadingAnchor.constraint(equalTo: lblContent.leadingAnchor),
            viewLine.trailingAnchor.constraint(equalTo: lblContent.trailingAnchor),
            viewLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            viewLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
