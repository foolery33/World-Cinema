//
//  AppDelegate.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 22.03.2023.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let collectionsDatabase = CollectionsDatabase(realm: setupRealm())
        
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController, collectionsDatabase: collectionsDatabase)
        appCoordinator?.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
    
    func setupRealm() -> Realm {
        do {
            return try Realm()
        } catch let error {
            fatalError("Failed to create Realm: \(error.localizedDescription)")
        }
    }

}

