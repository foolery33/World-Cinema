//
//  ProfileScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import UIKit

class ProfileScreenViewController: UIViewController {

    var viewModel: ProfileScreenViewModel!
    
    override func loadView() {
        let profileScreenView = ProfileScreenView(viewModel: self.viewModel)
        view = profileScreenView
        profileScreenView.loadProfile()
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
