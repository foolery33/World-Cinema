//
//  MainTabBarCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import Foundation
import UIKit

class MainTabBarCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var collectionsDatabase: CollectionsDatabase
    
    // MARK: ViewModels
    var mainViewModel: MainScreenViewModel
//    var compilationViewModel : CompilationScreenViewModel
    var collectionsViewModel: CollectionsScreenViewModel
    var profileViewModel: ProfileScreenViewModel
    
    init(navigationController: UINavigationController, mainViewModel: MainScreenViewModel, collectionsViewModel: CollectionsScreenViewModel, profileViewModel: ProfileScreenViewModel, collectionsDatabase: CollectionsDatabase) {
        self.navigationController = navigationController
        self.mainViewModel = mainViewModel
        self.collectionsViewModel = collectionsViewModel
        self.profileViewModel = profileViewModel
        self.collectionsDatabase = collectionsDatabase
    }
    
    func start() {
        initializeMainTabBar()
    }
    
    private func initializeMainTabBar() {
        let viewController = MainTabBarController()
        viewController.view.backgroundColor = UIColor(named: "BackgroundColor")
        
        // MARK: - MainScreen
        
        let mainNavigationController = UINavigationController()
        mainNavigationController.setNavigationBarHidden(true, animated: false)
        let mainCoordinator = MainCoordinator(
            navigationController: mainNavigationController,
            mainViewModel: MainScreenViewModel(coverRepository: CoverRepositoryImplementation()),
            movieViewModel: MovieScreenViewModel(movieRepository: MovieRepositoryImplementation()),
            episodeViewModel: EpisodeScreenViewModel(collectionsRepository: CollectionsRepositoryImplementation(), collectionsDatabase: self.collectionsDatabase))
        mainCoordinator.parentCoordinator = parentCoordinator
        
        let mainItem = UITabBarItem()
        mainItem.title = "Главное"
        mainItem.image = UIImage(named: "Main")
        mainNavigationController.tabBarItem = mainItem
        
//        // MARK: - CompilationScreen
//        
//        let compilationNavigationController = UINavigationController()
//        let compilationCoordinator = CompilationCoordinator(navigationController: compilationNavigationController, compilationViewModel: CompilationViewModel())
//        compilationCoordinator.parentCoordinator = parentCoordinator
//        
//        let compilationItem = UITabBarItem()
//        compilationItem.title = "Подборка"
//        compilationItem.image = UIImage(named: "Compilation")
//        
        // MARK: - Collections
        
        let collectionsNavigationController = UINavigationController()
        collectionsNavigationController.setNavigationBarHidden(true, animated: false)
        let collectionsCoordinator = CollectionsCoordinator(
            navigationController: collectionsNavigationController,
            collectionsViewModel: self.collectionsViewModel,
            collectionViewModel: CollectionScreenViewModel(
                collectionsRepository: CollectionsRepositoryImplementation(),
                collection: CollectionModel(collectionId: "", name: "")),
            createCollectionViewModel: CreateCollectionScreenViewModel(
                collectionsRepository: CollectionsRepositoryImplementation(),
                collectionsDatabase: self.collectionsDatabase),
            movieViewModel: MovieScreenViewModel(movieRepository: MovieRepositoryImplementation()),
            episodeViewModel: EpisodeScreenViewModel(collectionsRepository: CollectionsRepositoryImplementation(), collectionsDatabase: self.collectionsDatabase), changeCollectinViewModel: ChangeCollectionScreenViewModel(
                collection: CollectionModel(collectionId: "", name: ""),
                collectionsDatabase: self.collectionsDatabase, collectionsRepository: CollectionsRepositoryImplementation(), deleteCollectionDelegate: self.collectionsViewModel, changeCollectionNameDelegate: self.collectionsViewModel)
        )
        collectionsCoordinator.parentCoordinator = parentCoordinator
        
        let collectionsItem = UITabBarItem()
        collectionsItem.title = "Коллекции"
        collectionsItem.image = UIImage(named: "Collections")
        collectionsNavigationController.tabBarItem = collectionsItem

        // MARK: - Profile
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController, profileViewModel: self.profileViewModel)
        profileCoordinator.parentCoordinator = parentCoordinator
        
        let profileItem = UITabBarItem()
        profileItem.title = "Профиль"
        profileItem.image = UIImage(named: "Profile")
        profileNavigationController.tabBarItem = profileItem
        
//        viewController.viewControllers = [mainNavigationController, compilationNavigationController, collectionsNavigationController, profileNavigationController]
        viewController.viewControllers = [mainNavigationController, collectionsNavigationController, profileNavigationController]
        navigationController.pushViewController(viewController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        parentCoordinator?.children.append(mainCoordinator)
//        parentCoordinator?.children.append(compilationCoordinator)
        parentCoordinator?.children.append(collectionsCoordinator)
        parentCoordinator?.children.append(profileCoordinator)
        
        mainCoordinator.start()
//        compilationCoordinator.start()
        collectionsCoordinator.start()
        profileCoordinator.start()
        
    }
    
}
