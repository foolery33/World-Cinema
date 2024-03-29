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
    var compilationViewModel : CompilationScreenViewModel
    var collectionsViewModel: CollectionsScreenViewModel
    var profileViewModel: ProfileScreenViewModel
    
    init(navigationController: UINavigationController, mainViewModel: MainScreenViewModel, compilationViewModel: CompilationScreenViewModel, collectionsViewModel: CollectionsScreenViewModel, profileViewModel: ProfileScreenViewModel, collectionsDatabase: CollectionsDatabase) {
        self.navigationController = navigationController
        self.mainViewModel = mainViewModel
        self.compilationViewModel = compilationViewModel
        self.collectionsViewModel = collectionsViewModel
        self.profileViewModel = profileViewModel
        self.collectionsDatabase = collectionsDatabase
    }
    
    func start() {
        initializeMainTabBar()
    }
    
    private func initializeMainTabBar() {
        let viewController = MainTabBarController()
        viewController.view.backgroundColor = R.color.backgroundColor()
        
        // MARK: - MainScreen
        
        let mainNavigationController = UINavigationController()
        mainNavigationController.setNavigationBarHidden(true, animated: false)
        let mainCoordinator = MainCoordinator(
            navigationController: mainNavigationController,
            mainViewModel: self.mainViewModel,
            movieViewModel: MovieScreenViewModel(
                movieRepository: MovieRepositoryImplementation(),
                getAgeLimitUseCase: GetAgeLimitLabelUseCase(),
                getGenresListFromTagsUseCase: GetGenresListFromTagsUseCase()
            ),
            episodeViewModel: EpisodeScreenViewModel(collectionsRepository: CollectionsRepositoryImplementation(), episodesRepository: EpisodesRepositoryImplementation(), collectionsDatabase: self.collectionsDatabase))
        mainCoordinator.parentCoordinator = parentCoordinator
        
        let mainItem = UITabBarItem()
        mainItem.title = R.string.mainScreenStrings.home()
        mainItem.image = R.image.main()
        mainNavigationController.tabBarItem = mainItem
        
        // MARK: - CompilationScreen
        
        let compilationNavigationController = UINavigationController()
        let compilationCoordinator = CompilationCoordinator(navigationController: compilationNavigationController, compilationViewModel: self.compilationViewModel, movieViewModel: MovieScreenViewModel(
            movieRepository: MovieRepositoryImplementation(),
            getAgeLimitUseCase: GetAgeLimitLabelUseCase(),
            getGenresListFromTagsUseCase: GetGenresListFromTagsUseCase()
        ), episodeViewModel: EpisodeScreenViewModel(collectionsRepository: CollectionsRepositoryImplementation(), episodesRepository: EpisodesRepositoryImplementation(), collectionsDatabase: self.collectionsDatabase))
        compilationCoordinator.parentCoordinator = parentCoordinator
        
        let compilationItem = UITabBarItem()
        compilationItem.title = R.string.mainScreenStrings.compilation()
        compilationItem.image = R.image.compilation()
        compilationNavigationController.tabBarItem = compilationItem
        
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
            movieViewModel: MovieScreenViewModel(
                movieRepository: MovieRepositoryImplementation(),
                getAgeLimitUseCase: GetAgeLimitLabelUseCase(),
                getGenresListFromTagsUseCase: GetGenresListFromTagsUseCase()
            ),
            episodeViewModel: EpisodeScreenViewModel(collectionsRepository: CollectionsRepositoryImplementation(), episodesRepository: EpisodesRepositoryImplementation(), collectionsDatabase: self.collectionsDatabase), changeCollectinViewModel: ChangeCollectionScreenViewModel(
                collection: CollectionModel(collectionId: "", name: ""),
                collectionsDatabase: self.collectionsDatabase, collectionsRepository: CollectionsRepositoryImplementation(), deleteCollectionDelegate: self.collectionsViewModel, changeCollectionNameDelegate: self.collectionsViewModel)
        )
        collectionsCoordinator.parentCoordinator = parentCoordinator
        
        let collectionsItem = UITabBarItem()
        collectionsItem.title = R.string.mainScreenStrings.collections()
        collectionsItem.image = R.image.collections()
        collectionsNavigationController.tabBarItem = collectionsItem

        // MARK: - Profile
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController, profileViewModel: self.profileViewModel)
        profileCoordinator.parentCoordinator = parentCoordinator
        
        let profileItem = UITabBarItem()
        profileItem.title = R.string.mainScreenStrings.profile()
        profileItem.image = R.image.profile()
        profileNavigationController.tabBarItem = profileItem
        
        viewController.viewControllers = [mainNavigationController, compilationNavigationController, collectionsNavigationController, profileNavigationController]
        
        navigationController.pushViewController(viewController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        parentCoordinator?.children.append(mainCoordinator)
        parentCoordinator?.children.append(compilationCoordinator)
        parentCoordinator?.children.append(collectionsCoordinator)
        parentCoordinator?.children.append(profileCoordinator)
        
        mainCoordinator.start()
        compilationCoordinator.start()
        collectionsCoordinator.start()
        profileCoordinator.start()
        
    }
    
}
