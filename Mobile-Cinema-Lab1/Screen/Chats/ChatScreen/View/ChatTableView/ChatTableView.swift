//
//  ChatTableView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import UIKit

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
        
        if(viewModel?.dateIndicies[indexPath.row] is String) {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatDateTableViewCell.identifier, for: indexPath) as! ChatDateTableViewCell
            cell.setup(date: viewModel?.dateIndicies[indexPath.row] as! String)
            return cell
        }
        else {
            let message = viewModel?.dateIndicies[indexPath.row] as! MessageModel
            
            if(message.authorId == UserDataManager.shared.fetchUserId()) {
                
                // Если следующее сообщение написано тем же человеком, то надо сделать маленькое пространство между сообщениями:
                if indexPath.row + 1 < viewModel?.dateIndicies.count ?? 0 {
                    if(viewModel!.dateIndicies[indexPath.row + 1] is MessageModel) {
                        let nextMessage = viewModel?.dateIndicies[indexPath.row + 1] as! MessageModel
                        if(message.authorId == nextMessage.authorId) {
                            let cell = tableView.dequeueReusableCell(withIdentifier: ChatMyMessageTableViewCell.identifier, for: indexPath) as! ChatMyMessageTableViewCell
                            cell.setup(message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel, bottomSpacing: 4)
                            return cell
                        }
                        else {
                            let cell = tableView.dequeueReusableCell(withIdentifier: ChatMyMessageTableViewCell.identifier, for: indexPath) as! ChatMyMessageTableViewCell
                            cell.setup(message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel, bottomSpacing: 16)
                            return cell
                        }
                    }
                    else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: ChatMyMessageTableViewCell.identifier, for: indexPath) as! ChatMyMessageTableViewCell
                        cell.setup(message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel, bottomSpacing: 24)
                        return cell
                    }
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ChatMyMessageTableViewCell.identifier, for: indexPath) as! ChatMyMessageTableViewCell
                    cell.setup(message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel, bottomSpacing: 16)
                    return cell
                }
            }
            else {
                // Если следующее сообщение написано не тем же человеком, то надо сделать маленькое пространство между сообщениями:
                if indexPath.row + 1 < viewModel?.dateIndicies.count ?? 0 {
                    if(viewModel?.dateIndicies[indexPath.row + 1] is MessageModel) {
                        let nextMessage = viewModel?.dateIndicies[indexPath.row + 1] as! MessageModel
                        if(message.authorId == nextMessage.authorId) {
                            let cell = tableView.dequeueReusableCell(withIdentifier: ChatNotMyMessageTableViewCell.identifier, for: indexPath) as! ChatNotMyMessageTableViewCell
                            cell.setup(message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel, bottomSpacing: 4)
                            return cell
                        }
                        else {
                            let cell = tableView.dequeueReusableCell(withIdentifier: ChatNotMyMessageTableViewCell.identifier, for: indexPath) as! ChatNotMyMessageTableViewCell
                            cell.setup(message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel, bottomSpacing: 16)
                            return cell
                        }
                    }
                    else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: ChatNotMyMessageTableViewCell.identifier, for: indexPath) as! ChatNotMyMessageTableViewCell
                        cell.setup(message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel, bottomSpacing: 24)
                        return cell
                    }
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ChatNotMyMessageTableViewCell.identifier, for: indexPath) as! ChatNotMyMessageTableViewCell
                    cell.setup(message: viewModel?.dateIndicies[indexPath.row]! as! MessageModel, bottomSpacing: 16)
                    return cell
                }
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
}

extension ChatTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(viewModel?.dateIndicies[indexPath.row] is String) {
            let data = viewModel?.dateIndicies[indexPath.row] as! String
            return data.calculateLabelSize(font: .systemFont(ofSize: 14, weight: .regular), widthInset: 32, heightInset: 14).height + 24
        }
        else {
            let message = viewModel?.dateIndicies[indexPath.row] as! MessageModel
            if(message.authorId == UserDataManager.shared.fetchUserId()) {
                if indexPath.row + 1 < viewModel?.dateIndicies.count ?? 0 {
                    if(viewModel?.dateIndicies[indexPath.row + 1] is MessageModel) {
                        let nextMessage = viewModel?.dateIndicies[indexPath.row + 1] as! MessageModel
                        if(message.authorId == nextMessage.authorId) {
                            return ChatTableView.automaticDimension
                        }
                    }
                }
                return ChatTableView.automaticDimension
            }
            else {
                return ChatTableView.automaticDimension
            }
        }
    }
}
