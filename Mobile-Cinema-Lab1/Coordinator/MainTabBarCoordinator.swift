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
    
    // MARK: ViewModels
    var mainViewModel: MainScreenViewModel
//    var compilationViewModel : CompilationScreenViewModel
//    var collectionsViewModel: CollectionsScreenViewModel
//    var profileViewModel: ProfileScreenViewModel
    
    init(navigationController: UINavigationController, mainViewModel: MainScreenViewModel) {
        self.navigationController = navigationController
        self.mainViewModel = mainViewModel
    }
    
    func start() {
        initializeMainTabBar()
    }
    
    private func initializeMainTabBar() {
        let viewController = MainTabBarController()
        viewController.tabBar.frame.size.height = 99
        
        // MARK: - MainScreen
        
        let mainNavigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: mainNavigationController, mainViewModel: MainScreenViewModel(), movieViewModel: MovieScreenViewModel())
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
//        // MARK: - Collections
//        
//        let collectionsNavigationController = UINavigationController()
//        let collectionsCoordinator = CollectionsCoordinator(navigationController: collectionsNavigationController, collectionsViewModel: CollectionsViewModel())
//        collectionsCoordinator.parentCoordinator = parentCoordinator
//        
//        let collectionsItem = UITabBarItem()
//        collectionsItem.title = "Коллекции"
//        collectionsItem.image = UIImage(named: "Collections")
//        
//        // MARK: - Profile
//        
//        let profileNavigationController = UINavigationController()
//        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController, profileViewModel: ProfileViewModel())
//        profileCoordinator.parentCoordinator = parentCoordinator
//        
//        let profileItem = UITabBarItem()
//        profileItem.title = "Профиль"
//        profileItem.image = UIImage(named: "Profile")
        
//        viewController.viewControllers = [mainNavigationController, compilationNavigationController, collectionsNavigationController, profileNavigationController]
        viewController.viewControllers = [mainNavigationController]
        navigationController.pushViewController(viewController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)
        
        parentCoordinator?.children.append(mainCoordinator)
//        parentCoordinator?.children.append(compilationCoordinator)
//        parentCoordinator?.children.append(collectionsCoordinator)
//        parentCoordinator?.children.append(profileCoordinator)
        
        mainCoordinator.start()
//        compilationCoordinator.start()
//        collectionsCoordinator.start()
//        profileCoordinator.start()
        
    }
    
}
