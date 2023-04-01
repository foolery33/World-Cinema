//
//  RegisterScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit
import SnapKit

class RegisterScreenView: UIView {

    var viewModel: RegisterScreenViewModel

    init(viewModel: RegisterScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        setupSubviews()
        addKeyboardDidmiss()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private enum Paddings {
        static let betweenTopAndLogo = 88.0
        static let betweenLogoAndName = 64.0
        static let defaultPadding = 16.0
        static let betweenBottomAndLogin = 44.0
        static let textFieldVertical = 13.0
    }
    enum Scales {
        fileprivate static let textFieldHeight = 44.0
        fileprivate static let buttonHeight = 44.0
        public static let passwordEyeSize = 22.0
    }
    private enum Strings {
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

    func setupSubviews() {
        setupLogo()
        setupButtonsStackView()
        setupScrollView()
//        setupTextFieldsStackView()
//        setupButtonsStackView()
    }

    // MARK: Keyboard dismiss

    func addKeyboardDidmiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    @objc
    func dismissKeyboard() {
        endEditing(true)
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

    // MARK: - ScrollView setup

    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    private func setupScrollView() {
        addSubview(scrollView)
        setupTextFieldsStackView()
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(logotype.snp.bottom).offset(Paddings.betweenLogoAndName)
            make.bottom.greaterThanOrEqualTo(buttonsStackView.snp.top).offset(-16)
            make.width.equalToSuperview()
        }
    }

    // MARK: - TextFields StackView setup

    private lazy var textFieldsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = Paddings.defaultPadding
        myStackView.addArrangedSubview(nameTextField)
        myStackView.addArrangedSubview(surnameTextField)
        myStackView.addArrangedSubview(emailTextField)
        myStackView.addArrangedSubview(passwordTextField)
        myStackView.addArrangedSubview(confirmPasswordTextField)
        return myStackView
    }()
    private func setupTextFieldsStackView() {
        scrollView.addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-32)
        }
    }

    // MARK: Name setup

    private lazy var nameTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.name, placeholderText: Strings.name, selector: #selector(updateName(_:)))
    }()
    @objc
    private func updateName(_ textField: OutlinedTextField) {
        self.viewModel.name = textField.text ?? ""
    }

    // MARK: Surname setup

    private lazy var surnameTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.surname, placeholderText: Strings.surname, selector: #selector(updateSurname(_:)))
    }()
    @objc
    private func updateSurname(_ textField: OutlinedTextField) {
        self.viewModel.surname = textField.text ?? ""
    }

    // MARK: Email setup

    private lazy var emailTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.email, placeholderText: Strings.email, selector: #selector(updateEmail(_:)))
    }()
    @objc
    func updateEmail(_ textField: OutlinedTextField) {
        self.viewModel.email = textField.text ?? ""
    }

    // MARK: Password setup

    private lazy var passwordTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: true, passwordEye: passwordEye)
        return textField.getOutlinedTextField(text: viewModel.password, placeholderText: Strings.password, selector: #selector(updatePassword(_:)))
    }()
    private lazy var passwordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: "eye.slash")!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(.redColor), for: .normal)
        eye.setImage(UIImage(systemName: "eye")!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(.redColor), for: .selected)
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
    private lazy var confirmPasswordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: "eye.slash")!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(.redColor), for: .normal)
        eye.setImage(UIImage(systemName: "eye")!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(.redColor), for: .selected)
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

    // MARK: Buttons StackView setup

    private lazy var buttonsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = Paddings.defaultPadding
        myStackView.addArrangedSubview(registerButton)
        myStackView.addArrangedSubview(backToLoginScreenButton)
        return myStackView
    }()
    private func setupButtonsStackView() {
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-Paddings.betweenBottomAndLogin)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }

    // MARK: Back to login screen button setup

    private lazy var backToLoginScreenButton: OutlinedButton = {
        let button = OutlinedButton()
        return button.getOutlinedButton(label: Strings.alreadyHaveAccount, selector: #selector(goToLoginScreen))
    }()
    @objc
    func goToLoginScreen() {
        self.viewModel.loginButtonTapped()
    }

    // MARK: Register setup

    private lazy var registerButton: FilledButton = {
        let button = FilledButton()
        return button.getFilledButton(label: Strings.register, selector: #selector(goToMainScreen))
    }()
    @objc
    func goToMainScreen() {
        let activityIndicator = ActivityIndicator()
        addSubview(activityIndicator)
        activityIndicator.setupAnimation()
        viewModel.register { success in
            activityIndicator.stopAnimation()
            if(success) {
                self.viewModel.coordinator.goToMainScreen()
            }
            else {
                self.showAlert(title: Strings.registerFailed, message: self.viewModel.error)
            }
        }
    }

}

extension UIView {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        if let viewController = self.next as? UIViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
