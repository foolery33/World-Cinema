//
//  MainTabBarController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//
//
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let normalTabBarAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 10, weight: .medium),
        .foregroundColor: R.color.grayTextColor() ?? UIColor.grayTextColor
    ]
    let selectedTabBarAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 10, weight: .medium),
        .foregroundColor: UIColor.redColor
    ]
    
    private func updateTabBarAttributes() {
        guard let viewControllers = viewControllers else { return }
        for viewController in viewControllers {
            if viewController == selectedViewController {
                viewController.tabBarItem.setTitleTextAttributes(selectedTabBarAttributes, for: .normal)
            } else {
                viewController.tabBarItem.setTitleTextAttributes(normalTabBarAttributes, for: .normal)
            }
        }
    }
    
    override var selectedIndex: Int {
        didSet {
            updateTabBarAttributes()
        }
    }
    
    override var selectedViewController: UIViewController? {
        didSet { 
            updateTabBarAttributes()
        }
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.barTintColor = .white
        tabBar.backgroundColor = .tabbarColor
        tabBar.tintColor = .redColor
        tabBar.barTintColor = .tabbarColor
        tabBar.unselectedItemTintColor = .grayTextColor
        tabBar.isTranslucent = false
        tabBar.itemPositioning = .centered
    }

}
