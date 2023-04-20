//
//  ChatListScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation

final class ChatListScreenViewModel {
    
    weak var coordinator: ChatsCoordinator?
    private var model = ChatListScreenModel()
    private var chatsRepository: ChatsRepository
    
    init(chatsRepository: ChatsRepository) {
        self.chatsRepository = chatsRepository
    }
    
    var chats: [ChatModel] {
        get {
            model.chats
        }
        set {
            model.chats = newValue
        }
    }
    
    var error: String = ""
    
    func goBackToProfileScreen() {
        self.coordinator?.goBackToProfileScreen()
    }
    
    func goToChatScreen(chat: ChatModel) {
        self.coordinator?.goToChatScreen(chat: chat)
    }
    
    func getChatList(completion: @escaping (Bool) -> Void) {
        self.chatsRepository.getChatList { [weak self] result in
            switch result {
            case .success(let data):
                self?.chats = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
