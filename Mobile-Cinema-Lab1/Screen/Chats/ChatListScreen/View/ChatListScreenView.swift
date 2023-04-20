//
//  ChatListScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import UIKit
import SnapKit

class ChatListScreenView: UIView {

    var viewModel: ChatListScreenViewModel
    
    init(viewModel: ChatListScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupCollectionMoviesTableView()
    }
    
    // MARK: ChatListTableView setup
    
    private lazy var chatListTableView: ChatListTableView = {
        let myTableView = ChatListTableView()
        myTableView.viewModel = self.viewModel
        myTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
        return myTableView
    }()
    private func setupCollectionMoviesTableView() {
        addSubview(chatListTableView)
    }
    
}

extension ChatListScreenView {
    func loadChatList() {
        self.setupActivityIndicator()
        self.viewModel.getChatList { success in
            self.stopActivityIndicator()
            if(success) {
                self.chatListTableView.reloadData()
                self.chatListTableView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
            else {
                self.showAlert(title: "Chat List Loading Error", message: self.viewModel.error)
            }
        }
    }
}
