//
//  ChatListScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import UIKit
import SnapKit
import SkeletonView

class ChatListScreenView: UIView {

    var viewModel: ChatListScreenViewModel
    
    init(viewModel: ChatListScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.isSkeletonable = true
        setupSubviews()
        setupSkeleton()
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
        myTableView.isSkeletonable = true
        myTableView.viewModel = self.viewModel
        myTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
        return myTableView
    }()
    private func setupCollectionMoviesTableView() {
        addSubview(chatListTableView)
        chatListTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension ChatListScreenView {
    
    func setupSkeleton() {
        self.isSkeletonable = true
        self.showAnimatedSkeleton(usingColor: R.color.skeletonViewColor() ?? UIColor.skeletonViewColor)
    }
    func stopSkeleton() {
        self.hideSkeleton()
    }
    
    func loadChatList() {
//        setupSkeleton()
        self.viewModel.getChatList { success in
            self.stopSkeleton()
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
