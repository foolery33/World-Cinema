//
//  RegisterViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var viewModel: RegisterScreenViewModel!
    
    override func loadView() {
        let registerScreenView = RegisterScreenView(viewModel: self.viewModel)
        view = registerScreenView
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        view.backgroundColor = R.color.backgroundColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
