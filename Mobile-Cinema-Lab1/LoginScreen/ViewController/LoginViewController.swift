//
//  LoginViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class LoginViewController: UIViewController {

    var viewModel: LoginScreenViewModel!
    
    private let loginScreenView = LoginScreenView()
    
    override func loadView() {
        loginScreenView.viewModel = self.viewModel
        view = loginScreenView
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
