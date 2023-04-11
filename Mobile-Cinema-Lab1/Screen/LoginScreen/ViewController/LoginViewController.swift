//
//  LoginViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class LoginViewController: UIViewController {

    var viewModel: LoginScreenViewModel!
    
    override func loadView() {
        let loginScreenView = LoginScreenView(viewModel: self.viewModel)
        view = loginScreenView
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
