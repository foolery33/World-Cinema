//
//  ChatTableView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import UIKit
import SkeletonView

class ChatTableView: UITableView {

    var viewModel: ChatScreenViewModel?

    init() {
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        dataSource = self
        delegate = self
        separatorStyle = .none
        backgroundColor = .clear
        self.register(ChatMyMessageTableViewCell.self, forCellReuseIdentifier: ChatMyMessageTableViewCell.identifier)
        self.register(ChatNotMyMessageTableViewCell.self, forCellReuseIdentifier: ChatNotMyMessageTableViewCell.identifier)
        self.register(ChatDateTableViewCell.self, forCellReuseIdentifier: ChatDateTableViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ChatTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.groupedMessages.count ?? 0) + (viewModel?.messages.count ?? 0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isDate(index: indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatDateTableViewCell.identifier, for: indexPath) as! ChatDateTableViewCell
            cell.setup(date: viewModel?.dateIndicies[indexPath.row] as! String)
            return cell
        }
        let message = viewModel?.dateIndicies[indexPath.row] as! MessageModel
        return getSetupCellWithBottomSpacing(
            tableView: tableView,
            indexPath: indexPath,
            isMyMessage: isMyMessage(message: message),
            spacing: getBottomSpacingForCell(
                message: message,
                indexPath: indexPath
            )
        )
    }
}

extension ChatTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if(viewModel?.dateIndicies[indexPath.row] is String) {
            let data = viewModel?.dateIndicies[indexPath.row] as! String
            return data.calculateLabelSize(
                font: .systemFont(ofSize: 14, weight: .regular),
                widthInset: 32,
                heightInset: 14
            ).height + 24
        } else {
            return ChatTableView.automaticDimension
        }
    }
}

extension ChatTableView {
    func getSetupCellWithBottomSpacing(
        tableView: UITableView,
        indexPath: IndexPath,
        isMyMessage: Bool,
        spacing: CGFloat
    ) -> UITableViewCell {
        if isMyMessage {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ChatMyMessageTableViewCell.identifier,
                for: indexPath
            ) as? ChatMyMessageTableViewCell {
                cell.setup(
                    message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel,
                    bottomSpacing: spacing
                )
                return cell
            }
        }
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatNotMyMessageTableViewCell.identifier,
            for: indexPath
        ) as? ChatNotMyMessageTableViewCell {
            cell.setup(
                message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel,
                bottomSpacing: spacing
            )
            return cell
        }
        return UITableViewCell()
    }

    func getBottomSpacingForCell(message: MessageModel, indexPath: IndexPath) -> CGFloat {
        guard isNotLastMessage(indexPath: indexPath) else {
            return 16
        }
        if isTheSameAuthorOfNextMessage(message: message, indexPath: indexPath) {
            return 4
        }
        if isDate(index: indexPath.row + 1) {
            return 24
        }
        return 16
    }

    func isTheSameAuthorOfNextMessage(message: MessageModel, indexPath: IndexPath) -> Bool {
        if isNotLastMessage(indexPath: indexPath) {
            if isMessage(index: indexPath.row + 1) {
                let nextMessage = viewModel?.dateIndicies[indexPath.row + 1] as! MessageModel
                if(message.authorId == nextMessage.authorId) {
                    return true
                }
            }
        }
        return false
    }

    func isMyMessage(message: MessageModel) -> Bool {
        return message.authorId == UserDataManager.shared.fetchUserId()
    }

    func isMessage(index: Int) -> Bool {
        return viewModel?.dateIndicies[index] is MessageModel
    }

    func isDate(index: Int) -> Bool {
        return viewModel?.dateIndicies[index] is String
    }

    func isNotLastMessage(indexPath: IndexPath) -> Bool {
        return indexPath.row + 1 < viewModel?.dateIndicies.count ?? 0
    }
}
