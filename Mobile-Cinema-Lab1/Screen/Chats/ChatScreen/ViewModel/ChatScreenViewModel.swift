//
//  ChatViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation

protocol ChatUpdateProtocol: AnyObject {
    func updateChat()
}

final class ChatScreenViewModel {
    
    weak var coordinator: ChatsCoordinator?
    private var model = ChatScreenModel()
    private var profileRepository: ProfileRepository
    var chat: ChatModel?
    weak var chatUpdater: ChatUpdateProtocol?
    var chatManager: ChatManager?
    var dateIndicies: [Int : Any] = [:]
    
    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    var messages: [MessageModel] {
        get {
            model.messages
        }
        set {
            model.messages = newValue
        }
    }
    
    var groupedMessages: [[MessageModel]] {
        get {
            model.groupedMessages
        }
        set {
            model.groupedMessages = newValue
        }
    }
    
    var error: String = ""
    
    func subscribe(chat: ChatModel) {
        self.chat = chat
        chatManager?.chatId = self.chat?.chatId
        chatManager?.subscribe()
    }
    func unsubscribe() {
        self.dateIndicies = [:]
        self.groupedMessages = [[]]
        self.messages = []
        chatManager?.unsubscribe()
        chatManager?.chatId = nil
        chatManager = nil
    }
    
    func goToPreviousScreen() {
        unsubscribe()
        print("unsubbed")
//        self.chatManager.socket = nil
        self.coordinator?.goToPreviousScreen()
    }
    
    func getUserId(completion: @escaping (Bool) -> Void) {
        if(UserDataManager.shared.fetchUserId().isEmpty) {
            self.profileRepository.getProfile { [weak self] result in
                switch result {
                case .success(let data):
                    UserDataManager.shared.saveUserId(userId: data.userId)
                    completion(true)
                case .failure(let error):
                    self?.error = error.errorDescription
                    completion(false)
                }
            }
        }
        else {
            completion(true)
        }
    }
    
    func sendMessage(_ message: String, completion: @escaping (Bool) -> Void) {
        if EmptyFieldValidation().isEmptyField(message) {
            self.error = AppError.chatsError(.emptyField).errorDescription
            completion(false)
        }
        else {
            self.chatManager?.sendMessage(message)
            completion(true)
        }
    }
    
    deinit {
        print("deinited")
    }
    
}

extension ChatScreenViewModel: DataProviderDelegate {
    func didReceive(result: Result<MessageModel, Error>) {
        switch result {
        case .success(let data):
            self.model.addMessage(message: data)
            self.groupedMessages = GroupMessagesByDateAndTimeUseCase().groupMessagesByDate(messages: self.messages)
            self.dateIndicies = RecognizeChatCellsUseCase().recognize(groupedMessages: &self.groupedMessages)
            self.chatUpdater?.updateChat()
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
}
