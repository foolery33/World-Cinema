//
//  ChangeCollectionScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 09.04.2023.
//

import UIKit

class ChangeCollectionScreenViewController: UIViewController {

    var viewModel: ChangeCollectionScreenViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareData()
    }
    
    override func loadView() {
        let changeCollectionScreenView = ChangeCollectionScreenView(viewModel: self.viewModel)
        view = changeCollectionScreenView
        view.backgroundColor = R.color.backgroundColor()
        self.title = R.string.changeCollectionScreenStrings.change_collection()
        navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = getNavigationLeftItem()
    }
    
    private func getNavigationLeftItem() -> UIBarButtonItem {
        let backItem = UIBarButtonItem(image: R.image.backArrow(), style: .plain, target: self, action: #selector(goBackToCollectionsScreen))
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        backItem.tintColor = .white
        return backItem
    }
    @objc private func goBackToCollectionsScreen() {
        viewModel.goBackToCollectionScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func prepareData() {
        self.viewModel.iconName = self.viewModel.getIconName()
        if let view = self.view as? ChangeCollectionScreenView {
            view.prepareData()
        }
    }

}

extension ChangeCollectionScreenViewController: ChooseIconDelegate {
    func choose(iconName: String) {
        if let myView = self.view as? ChangeCollectionScreenView {
            myView.changeIcon(iconName: iconName)
            viewModel.iconName = iconName
        }
    }
}
