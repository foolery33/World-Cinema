//
//  CreateCollectionScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 08.04.2023.
//

import UIKit

class CollectionScreenViewController: UIViewController {

    var viewModel: CollectionScreenViewModel!
    
    override func loadView() {
        let collectionScreenView = CollectionScreenView(viewModel: self.viewModel)
        view = collectionScreenView
        collectionScreenView.getMoviesFromCollection()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.title = viewModel.collection.name
        navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = getNavigationLeftItem()
        self.navigationItem.rightBarButtonItem = getNavigationRightItem()
    }
    
    private func getNavigationLeftItem() -> UIBarButtonItem {
        let backItem = UIBarButtonItem(image: UIImage(named: "BackArrow"), style: .plain, target: self, action: #selector(goBackToCollectionsScreen))
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        backItem.tintColor = .white
        return backItem
    }
    @objc private func goBackToCollectionsScreen() {
        viewModel.goBackToCollectionsScreen()
    }
    
    private func getNavigationRightItem() -> UIBarButtonItem {
        let backItem = UIBarButtonItem(image: UIImage(named: "Pencil"), style: .plain, target: self, action: #selector(goToEditCollectionScreen))
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        backItem.tintColor = .white
        return backItem
    }
    @objc private func goToEditCollectionScreen() {
//        viewModel.goToEditCollectionScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
