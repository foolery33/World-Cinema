//
//  ChatsCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation
import UIKit

final class ChatsCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: ViewModels
    
    var chatListViewModel: ChatListScreenViewModel
    var chatViewModel: ChatScreenViewModel
    
    init(navigationController: UINavigationController, chatListViewModel: ChatListScreenViewModel, chatViewModel: ChatScreenViewModel) {
        self.navigationController = navigationController
        self.chatListViewModel = chatListViewModel
        self.chatViewModel = chatViewModel
    }
    
    func start() {
        goToChatListScreen()
    }

    func goToChatListScreen() {
        let chatListViewController = ChatListScreenViewController()
        self.chatListViewModel.coordinator = self
        chatListViewController.viewModel = self.chatListViewModel
        navigationController.pushViewController(chatListViewController, animated: true)
    }
    
    func goToChatScreen(chat: ChatModel, chatManager: ChatManager) {
        let chatViewController = ChatScreenViewController()
        self.chatViewModel.coordinator = self
        self.chatViewModel.chatUpdater = chatViewController
        self.chatViewModel.chatManager = chatManager
        self.chatViewModel.chatManager.delegate = self.chatViewModel
        self.chatViewModel.chat = chat
        chatViewController.viewModel = self.chatViewModel
        navigationController.pushViewController(chatViewController, animated: true)
    }
    
    func goToPreviousScreen() {
        self.navigationController.popViewController(animated: true)
    }
    
    func goBackToProfileScreen() {
        parentCoordinator?.childDidFinish(self)
        navigationController.popViewController(animated: true)
    }
    
}
