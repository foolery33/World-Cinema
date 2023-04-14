//
//  ChatScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import UIKit
import SnapKit

class ChatScreenView: UIView {

    var viewModel: ChatScreenViewModel
    
    init(viewModel: ChatScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupChatTableView()
    }
    
    // MARK: - ChatTableView setup
    
    private lazy var chatTableView: ChatTableView = {
        let myTableView = ChatTableView()
        myTableView.viewModel = self.viewModel
        return myTableView
    }()
    private func setupChatTableView() {
        addSubview(chatTableView)
    }
    
    func connectToWebSocket() {
        self.viewModel.subscribe(chat: self.viewModel.chat ?? ChatModel(chatId: "", chatName: ""))
    }
    
    func updateChat() {
        self.chatTableView.reloadData()
        self.chatTableView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func getUserId() {
        self.viewModel.getUserId { success in
            if(!success) {
                self.showAlert(title: "Preparation Error", message: self.viewModel.error)
            }
        }
    }
    
}
