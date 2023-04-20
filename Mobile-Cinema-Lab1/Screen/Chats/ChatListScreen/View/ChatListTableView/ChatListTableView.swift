//
//  ChatListTableView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import UIKit

class ChatListTableView: UITableView {
    
    var viewModel: ChatListScreenViewModel?
    
    init() {
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        dataSource = self
        delegate = self
        separatorStyle = .none
        backgroundColor = .clear
        self.register(ChatListTableViewCell.self, forCellReuseIdentifier: ChatListTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ChatListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.chats.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier, for: indexPath) as! ChatListTableViewCell
        let chat = viewModel?.chats[indexPath.row] ?? ChatModel(chatId: "", chatName: "", lastMessage: MessageModel(messageId: "", creationDateTime: "", authorName: "", text: ""))

        cell.setup(chat: chat)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.goToChatScreen(chat: self.viewModel?.chats[indexPath.row] ?? ChatModel(chatId: "", chatName: ""))
    }
}

extension ChatListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Scales.cellHeight
    }
}


extension ChatListTableView {
    func countHeight() -> CGFloat {
        print(CGFloat(viewModel?.chats.count ?? 0) * Scales.cellHeight)
        return CGFloat(viewModel?.chats.count ?? 0) * Scales.cellHeight
    }
}

private enum Scales {
    static let cellHeight: CGFloat = 80
}
