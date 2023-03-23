//
//  LoginScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit
import SnapKit

class LoginScreenView: UIView {

    var viewModel: LoginScreenViewModel!
    
    private enum Paddings {
        static let betweenLogoAndTop: Float = 132.0
        static let defaultPadding: Float = 16.0
        static let betweenLogoAndEmail: Float = 104.0
        static let betweenPasswordAndLogin: Float = 156.0
        static let betweenBottomAndRegister: Float = 44.0
    }
    private enum Scales {
        static let textFieldHeight = 44.0
        static let buttonHeight = 44.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    public lazy var logotype: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "LogoWithName")!
        return logo
    }()
    private func setupLogo() {
        addSubview(logotype)
        logotype.snp.makeConstraints { make in
            make.top.equalTo(safeAreaInsets.top).offset(Paddings.betweenLogoAndTop)
            make.centerX.equalTo(self)
            
        }
    }
    
    // MARK: Email setup
    
    public lazy var emailTextField: OutlinedTextField = {
        let textField = OutlinedTextField()
        return textField.getOutlinedTextField(placeholderText: "E-mail", isSecured: false, selector: #selector(updateEmail(_:)))
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
        return passwordTextField.getOutlinedTextField(placeholderText: "Password", isSecured: true, selector: #selector(updatePassword(_:)))
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
        return button.getOutlinedButton(label: "Регистрация", selector: #selector(printSomethingElse))
    }()
    @objc
    private func printSomethingElse() {
        
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
        return button.getFilledButton(label: "Войти", selector: #selector(printSomething))
    }()
    @objc
    private func printSomething() {
        
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
