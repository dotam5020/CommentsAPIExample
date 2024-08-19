//
//  BaseViewController.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindData()
        bindEvent()
    }
    
    func setupUI(){}
    func bindData(){}
    func bindEvent(){}
}
