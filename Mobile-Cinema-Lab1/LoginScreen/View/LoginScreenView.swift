//
//  LoginScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit
import SnapKit

class LoginScreenView: UIView {

    var viewModel: LoginScreenViewModel
    
    private enum Paddings {
        static let betweenTopAndLogo = 132.0
        static let defaultPadding = 16.0
        static let betweenLogoAndEmail = 104.0
        static let betweenPasswordAndLogin = 156.0
        static let betweenBottomAndRegister = 44.0
    }
    private enum Scales {
        static let textFieldHeight = 44.0
        static let buttonHeight = 44.0
    }
    private enum Strings {
        static let email = "E-mail"
        static let password = "Пароль"
        static let login = "Войти"
        static let register = "Регистрация"
    }
    
    init(viewModel: LoginScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        setupSubviews()
        addKeyboardDidmiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Global setup
    
    func setupSubviews() {
        setupLogo()
        setupEmailTextField()
        setupPasswordTextField()
        setupRegisterButton()
        setupLoginButton()
    }
    
    // MARK: Keyboard dismiss
    
    func addKeyboardDidmiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
    // MARK: Logotype setup
    
    private lazy var logotype: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "LogoWithName")!
        return logo
    }()
    private func setupLogo() {
        addSubview(logotype)
        logotype.snp.makeConstraints { make in
            make.top.equalTo(safeAreaInsets.top).offset(Paddings.betweenTopAndLogo)
            make.centerX.equalTo(self)
            
        }
    }
    
    // MARK: Email setup
    
    private lazy var emailTextField: OutlinedTextField = {
        let textField = OutlinedTextField()
        return textField.getOutlinedTextField(text: viewModel.email, placeholderText: Strings.email, isSecured: false, selector: #selector(updateEmail(_:)))
    }()
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
            make.height.equalTo(Scales.textFieldHeight)
            make.top.equalTo(logotype.snp.bottom).offset(Paddings.betweenLogoAndEmail)
        }
    }
    @objc
    private func updateEmail(_ textField: OutlinedTextField) {
        self.viewModel.email = textField.text ?? ""
    }
    
    // MARK: Password setup
    
    private lazy var passwordTextField: OutlinedTextField = {
        let passwordTextField = OutlinedTextField()
        return passwordTextField.getOutlinedTextField(text: viewModel.password, placeholderText: Strings.password, isSecured: true, selector: #selector(updatePassword(_:)))
    }()
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
            make.height.equalTo(Scales.textFieldHeight)
            make.top.equalTo(emailTextField.snp.bottom).offset(Paddings.defaultPadding)
        }
    }
    @objc
    private func updatePassword(_ textField: OutlinedTextField) {
        self.viewModel.password = textField.text ?? ""
    }
    
    // MARK: Register setup
    
    private lazy var registerButton: OutlinedButton = {
        let button = OutlinedButton()
        return button.getOutlinedButton(label: Strings.register, selector: #selector(goToRegisterScreen))
    }()
    @objc
    private func goToRegisterScreen() {
        viewModel.registerButtonTapped()
    }
    private func setupRegisterButton() {
        addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
            make.height.equalTo(Scales.buttonHeight)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(Paddings.betweenBottomAndRegister)
        }
    }
    
    // MARK: Login setup
    
    private lazy var loginButton: FilledButton = {
        let button = FilledButton()
        return button.getFilledButton(label: Strings.login, selector: #selector(goToMainScreen))
    }()
    @objc
    private func goToMainScreen() {
        
    }
    private func setupLoginButton() {
        addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
            make.height.equalTo(Scales.buttonHeight)
            make.bottom.equalTo(registerButton.snp.top).offset(-Paddings.defaultPadding)
        }
    }
    
}
