//
//  CollectionsScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import UIKit

class CollectionsScreenViewController: UIViewController {

    var viewModel: CollectionsScreenViewModel!
    
    override func loadView() {
        let collectionsScreenView = CollectionsScreenView(viewModel: self.viewModel)
        view = collectionsScreenView
        setupNavigationBarAppearence()
        collectionsScreenView.loadCollections()
    }
    
    private func setupNavigationBarAppearence() {
        navigationController?.isNavigationBarHidden = false
        let navigationBarTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: UIColor.white
        ]
        if let navBarAppearance = navigationController?.navigationBar.standardAppearance {
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
            navBarAppearance.titleTextAttributes = navigationBarTitleAttributes
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.topItem?.title = "Коллекции"
        }
        
        setupNavigationBarRightItem()
    }
    
    private func setupNavigationBarRightItem() {
        let backItem = UIBarButtonItem()
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        backItem.image = UIImage(named: "Plus")
        backItem.tintColor = .white
        navigationItem.rightBarButtonItem = backItem
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
