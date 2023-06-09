//
//  MainScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {

    var viewModel: MainScreenViewModel!
    
    override func loadView() {
        let mainScreenView = MainScreenView(viewModel: self.viewModel)
        view = mainScreenView
        view.backgroundColor = R.color.backgroundColor()
        mainScreenView.loadCover()
        mainScreenView.loadSections()
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
