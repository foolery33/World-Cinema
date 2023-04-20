//
//  AppCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    private var collectionsDatabase: CollectionsDatabase
    
    init(navigationController: UINavigationController, collectionsDatabase: CollectionsDatabase) {
        self.navigationController = navigationController
        self.collectionsDatabase = collectionsDatabase
    }
    
    func start() {
        if TokenManager.shared.fetchAccessToken().isEmpty {
            goToAuth()
        }
        else {
            goToMain()
        }
    }
    
    func goToAuth() {
        let authCoordinator = AuthCoordinator(
            navigationController: self.navigationController,
            loginViewModel: LoginScreenViewModel(
                authRepository: AuthRepositoryImplementation()),
            registerViewModel: RegisterScreenViewModel(
                authRepository: AuthRepositoryImplementation(),
                collectionsRepository: CollectionsRepositoryImplementation(),
                collectionsDatabase: self.collectionsDatabase))
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.start()
    }
    
    func goToMain() {
        let homeCoordinator = MainTabBarCoordinator(navigationController: self.navigationController, mainViewModel: MainScreenViewModel(coverRepository: CoverRepositoryImplementation()), compilationViewModel: CompilationScreenViewModel(movieRepository: MovieRepositoryImplementation(), collectionsRepository: CollectionsRepositoryImplementation()), collectionsViewModel: CollectionsScreenViewModel(collectionsRepository: CollectionsRepositoryImplementation(), collectionsDatabase: self.collectionsDatabase), profileViewModel: ProfileScreenViewModel(profileRepository: ProfileRepositoryImplementation()), collectionsDatabase: self.collectionsDatabase)
        children.append(homeCoordinator)
        homeCoordinator.parentCoordinator = self
        homeCoordinator.start()
    }
    
    func goToChats() {
        let chatsCoordinator = ChatsCoordinator(navigationController: self.navigationController, chatListViewModel: ChatListScreenViewModel(chatsRepository: ChatsRepositoryImplementation()), chatViewModel: ChatScreenViewModel(profileRepository: ProfileRepositoryImplementation()))
        children.append(chatsCoordinator)
        chatsCoordinator.parentCoordinator = self
        chatsCoordinator.start()
    }
    
    func goToChatScreen(chat: ChatModel) {
        let chatsCoordinator = ChatsCoordinator(navigationController: self.navigationController, chatListViewModel: ChatListScreenViewModel(chatsRepository: ChatsRepositoryImplementation()), chatViewModel: ChatScreenViewModel(profileRepository: ProfileRepositoryImplementation()))
        children.append(chatsCoordinator)
        chatsCoordinator.parentCoordinator = self
        chatsCoordinator.goToChatScreen(chat: chat)
    }
    
}
