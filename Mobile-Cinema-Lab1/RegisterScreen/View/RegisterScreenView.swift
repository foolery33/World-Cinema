//
//  RegisterScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class RegisterScreenView: UIView {

    var viewModel: RegisterScreenViewModel

    fileprivate enum Paddings {
        static let betweenTopAndLogo = 88.0
        static let betweenLogoAndName = 64.0
        static let defaultPadding = 16.0
        static let betweenBottomAndLogin = 44.0
        static let textFieldVertical = 13.0
    }
    fileprivate enum Scales {
        static let textFieldHeight = 44.0
        static let buttonHeight = 44.0
    }
    fileprivate enum Strings {
        static let name = "Имя"
        static let surname = "Фамилия"
        static let email = "E-mail"
        static let password = "Пароль"
        static let confirmPassword = "Повторите пароль"
        static let register = "Зарегистрироваться"
        static let alreadyHaveAccount = "У меня уже есть аккаунт"
        static let registerFailed = "Registration failed"
        static let ok = "OK"
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
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.name, placeholderText: Strings.name, selector: #selector(updateName(_:)))
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
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.surname, placeholderText: Strings.surname, selector: #selector(updateSurname(_:)))
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
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.email, placeholderText: Strings.email, selector: #selector(updateEmail(_:)))
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
        let textField = OutlinedTextField(isSecured: true, passwordEye: passwordEye)
        return textField.getOutlinedTextField(text: viewModel.password, placeholderText: Strings.password, selector: #selector(updatePassword(_:)))
    }()
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(Scales.textFieldHeight)
            make.top.equalTo(emailTextField.snp.bottom).offset(Paddings.defaultPadding)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    private lazy var passwordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: "eye.slash")!.resizeImage(newWidth: 24, newHeight: 24).withTintColor(.redColor), for: .normal)
        eye.setImage(UIImage(systemName: "eye")!.resizeImage(newWidth: 24, newHeight: 24).withTintColor(.redColor), for: .selected)
        eye.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return eye
    }()
    @objc
    func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected = !sender.isSelected
    }
    @objc
    func updatePassword(_ textField: OutlinedTextField) {
        self.viewModel.password = textField.text ?? ""
    }

    // MARK: Confirm password setup

    private lazy var confirmPasswordTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: true, passwordEye: confirmPasswordEye)
        return textField.getOutlinedTextField(text: viewModel.confirmPassword, placeholderText: Strings.confirmPassword, selector: #selector(updateConfirmPassword(_:)))
    }()
    private func setupConfirmPasswordTextField() {
        addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(Scales.textFieldHeight)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Paddings.defaultPadding)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    private lazy var confirmPasswordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: "eye.slash")!.resizeImage(newWidth: 24, newHeight: 24).withTintColor(.redColor), for: .normal)
        eye.setImage(UIImage(systemName: "eye")!.resizeImage(newWidth: 24, newHeight: 24).withTintColor(.redColor), for: .selected)
        eye.addTarget(self, action: #selector(toggleConfirmPasswordVisibility), for: .touchUpInside)
        return eye
    }()
    @objc
    func toggleConfirmPasswordVisibility(_ sender: UIButton) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        sender.isSelected = !sender.isSelected
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
        let activityIndicator = ActivityIndicator()
        addSubview(activityIndicator)
        activityIndicator.setupEdges()
        activityIndicator.startAnimating()
        viewModel.register { success in
            activityIndicator.stopAnimating()
            if(success) {
                self.viewModel.coordinator.goToMainScreen()
            }
            else {
                let alert = UIAlertController(title: Strings.registerFailed, message: self.viewModel.error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Strings.ok, style: .default))
                if let viewController = self.next as? UIViewController {
                    viewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}

enum UITextFieldPaddings {
    static let securedTextField = UIEdgeInsets(top: RegisterScreenView.Paddings.textFieldVertical, left: RegisterScreenView.Paddings.defaultPadding, bottom: RegisterScreenView.Paddings.textFieldVertical, right: RegisterScreenView.Paddings.defaultPadding * 3)
    static let textField = UIEdgeInsets(top: RegisterScreenView.Paddings.textFieldVertical, left: RegisterScreenView.Paddings.defaultPadding, bottom: RegisterScreenView.Paddings.textFieldVertical, right: RegisterScreenView.Paddings.defaultPadding)
    static let passwordEyeSize: CGFloat = 24.0
    static let padding: CGFloat = RegisterScreenView.Paddings.defaultPadding
}
