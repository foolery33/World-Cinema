//
//  CollectionsScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import UIKit

class CollectionsScreenViewController: UIViewController {
    
    var viewModel: CollectionsScreenViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let view = self.view as? CollectionsScreenView {
            view.reloadCollectionsTableView()
            print("appeared")
        }
    }
    
    override func loadView() {
        let collectionsScreenView = CollectionsScreenView(viewModel: self.viewModel)
        view = collectionsScreenView
        view.backgroundColor = UIColor(named: "BackgroundColor")
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
        }
        self.title = "Коллекции"
        self.navigationItem.rightBarButtonItem = getNavigationBarRightItem()
    }
    
    private func getNavigationBarRightItem() -> UIBarButtonItem {
        let backItem = UIBarButtonItem(image: UIImage(named: "Plus"), style: .plain, target: self, action: #selector(goToCreateCollectionScreen))
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        backItem.tintColor = .white
        return backItem
    }
    @objc private func goToCreateCollectionScreen() {
        viewModel.goToCreateCollectionScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
