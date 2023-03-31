//
//  MainTabBarController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let customTabBarHeight: CGFloat = 85
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = customTabBarHeight
        tabBarFrame.origin.y = view.frame.size.height - customTabBarHeight
        tabBar.frame = tabBarFrame
        tabBar.backgroundColor = .tabbarColor
        tabBar.tintColor = .redColor
        tabBar.barTintColor = .tabbarColor
        tabBar.unselectedItemTintColor = .grayTextColor
        tabBar.isTranslucent = false
        tabBar.itemPositioning = .centered
        tabBar.items?.forEach({ $0.imageInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)})
        tabBar.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -31) })
    }

}
