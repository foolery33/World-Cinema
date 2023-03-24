//
//  RegisterScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class RegisterScreenView: UIView {

    var viewModel: RegisterScreenViewModel

    private enum Paddings {
        static let betweenTopAndLogo = 88.0
        static let betweenLogoAndName = 64.0
        static let defaultPadding = 16.0
        static let betweenBottomAndLogin = 44.0
    }
    private enum Scales {
        static let textFieldHeight = 44.0
        static let buttonHeight = 44.0
    }
    private enum Strings {
        static let name = "Имя"
        static let surname = "Фамилия"
        static let email = "E-mail"
        static let password = "Пароль"
        static let confirmPassword = "Повторите пароль"
        static let register = "Зарегистрироваться"
        static let alreadyHaveAccount = "У меня уже есть аккаунт"
    }

    init(viewModel: RegisterScreenViewModel) {
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
        setupNameTextField()
        setupSurnameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupBackToLoginScreenButton()
        setupRegisterButton()
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

    // MARK: Name setup

    private lazy var nameTextField: OutlinedTextField = {
        let textField = OutlinedTextField()
        return textField.getOutlinedTextField(text: viewModel.name, placeholderText: Strings.name, isSecured: false, selector: #selector(updateName(_:)))
    }()
    private func setupNameTextField() {
        addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(logotype.snp.bottom).offset(Paddings.betweenLogoAndName)
            make.height.equalTo(Scales.textFieldHeight)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    @objc
    private func updateName(_ textField: OutlinedTextField) {
        self.viewModel.name = textField.text ?? ""
    }

    // MARK: Surname setup

    private lazy var surnameTextField: OutlinedTextField = {
        let textField = OutlinedTextField()
        return textField.getOutlinedTextField(text: viewModel.surname, placeholderText: Strings.surname, isSecured: false, selector: #selector(updateSurname(_:)))
    }()
    private func setupSurnameTextField() {
        addSubview(surnameTextField)
        surnameTextField.snp.makeConstraints { make in
            make.height.equalTo(Scales.textFieldHeight)
            make.top.equalTo(nameTextField.snp.bottom).offset(Paddings.defaultPadding)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    @objc
    private func updateSurname(_ textField: OutlinedTextField) {
        self.viewModel.surname = textField.text ?? ""
    }

    // MARK: Email setup

    private lazy var emailTextField: OutlinedTextField = {
        let textField = OutlinedTextField()
        return textField.getOutlinedTextField(text: viewModel.email, placeholderText: Strings.email, isSecured: false, selector: #selector(updateEmail(_:)))
    }()
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(Scales.textFieldHeight)
            make.top.equalTo(surnameTextField.snp.bottom).offset(Paddings.defaultPadding)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    @objc
    func updateEmail(_ textField: OutlinedTextField) {
        self.viewModel.email = textField.text ?? ""
    }

    // MARK: Password setup

    private lazy var passwordTextField: OutlinedTextField = {
        let textField = OutlinedTextField()
        return textField.getOutlinedTextField(text: viewModel.password, placeholderText: Strings.password, isSecured: true, selector: #selector(updatePassword(_:)))
    }()
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(Scales.textFieldHeight)
            make.top.equalTo(emailTextField.snp.bottom).offset(Paddings.defaultPadding)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    @objc
    func updatePassword(_ textField: OutlinedTextField) {
        self.viewModel.password = textField.text ?? ""
    }

    // MARK: Confirm password setup

    private lazy var confirmPasswordTextField: OutlinedTextField = {
        let textField = OutlinedTextField()
        return textField.getOutlinedTextField(text: viewModel.confirmPassword, placeholderText: Strings.confirmPassword, isSecured: true, selector: #selector(updateConfirmPassword(_:)))
    }()
    private func setupConfirmPasswordTextField() {
        addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(Scales.textFieldHeight)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Paddings.defaultPadding)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    @objc
    func updateConfirmPassword(_ textField: OutlinedTextField) {
        self.viewModel.confirmPassword = textField.text ?? ""
    }

    // MARK: Back to login screen button setup

    private lazy var backToLoginScreenButton: OutlinedButton = {
        let button = OutlinedButton()
        return button.getOutlinedButton(label: Strings.alreadyHaveAccount, selector: #selector(goToLoginScreen))
    }()
    private func setupBackToLoginScreenButton() {
        addSubview(backToLoginScreenButton)
        backToLoginScreenButton.snp.makeConstraints { make in
            make.height.equalTo(Scales.buttonHeight)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(Paddings.betweenBottomAndLogin)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    @objc
    func goToLoginScreen() {
        self.viewModel.loginButtonTapped()
    }

    // MARK: Register setup

    private lazy var registerButton: FilledButton = {
        let button = FilledButton()
        return button.getFilledButton(label: Strings.register, selector: #selector(goToMainScreen))
    }()
    private func setupRegisterButton() {
        addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(Scales.buttonHeight)
            make.bottom.equalTo(backToLoginScreenButton.snp.top).offset(-Paddings.defaultPadding)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    @objc
    func goToMainScreen() {
        
    }

}
