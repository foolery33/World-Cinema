//
//  RegisterViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    var viewModel: RegisterScreenViewModel!
    
//    private let registerScreenView = RegisterScreenView()
    
    override func loadView() {
        let registerScreenView = RegisterScreenView(viewModel: self.viewModel)
        view = registerScreenView
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
