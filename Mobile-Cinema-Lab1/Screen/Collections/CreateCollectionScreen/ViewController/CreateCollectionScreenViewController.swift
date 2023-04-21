//
//  CreateCollectionScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 05.04.2023.
//

import UIKit

class CreateCollectionScreenViewController: UIViewController {

    var viewModel: CreateCollectionScreenViewModel!
    
    override func loadView() {
        let collectionsScreenView = CreateCollectionScreenView(viewModel: self.viewModel)
        view = collectionsScreenView
        view.backgroundColor = R.color.backgroundColor()
        self.title = R.string.createCollectionScreenStrings.create_collection()
        navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = getNavigationLeftItem()
    }
    
    private func getNavigationLeftItem() -> UIBarButtonItem {
        let backItem = UIBarButtonItem(image: R.image.backArrow(), style: .plain, target: self, action: #selector(goBackToCreateCollectionScreen))
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        backItem.tintColor = .white
        return backItem
    }
    @objc private func goBackToCreateCollectionScreen() {
        viewModel.goBackToCreateCollectionScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension CreateCollectionScreenViewController: ChooseIconDelegate {
    func choose(iconName: String) {
        if let myView = self.view as? CreateCollectionScreenView {
            myView.changeIcon(iconName: iconName)
            viewModel.iconName = iconName
        }
    }
}
