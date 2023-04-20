//
//  SceneDelegate.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 20.04.2023.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let collectionsDatabase = CollectionsDatabase(realm: setupRealm())
        
        let navigationController = UINavigationController()
        
        appCoordinator = AppCoordinator(navigationController: navigationController, collectionsDatabase: collectionsDatabase)
        appCoordinator?.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setupRealm() -> Realm {
        do {
            return try Realm()
        } catch let error {
            fatalError("Failed to create Realm: \(error.localizedDescription)")
        }
    }

}

