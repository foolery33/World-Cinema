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
    
    func setupSubviews() {
        setupLogo()
        setupButtonsStackView()
        setupScrollView()
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
        logo.image = R.image.logoWithName()!
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
            make.bottom.greaterThanOrEqualTo(buttonsStackView.snp.top).offset(Paddings.defaultNegativePadding)
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
            make.leading.equalToSuperview().inset(Paddings.defaultPadding)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(Paddings.doubleDefaultNegativePadding)
        }
    }
    
    // MARK: Name setup
    
    private lazy var nameTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.name, placeholderText: R.string.registerScreenStrings.name(), selector: #selector(updateName(_:)))
    }()
    @objc
    private func updateName(_ textField: OutlinedTextField) {
        self.viewModel.name = textField.text ?? ""
    }
    
    // MARK: Surname setup
    
    private lazy var surnameTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.surname, placeholderText: R.string.registerScreenStrings.surname(), selector: #selector(updateSurname(_:)))
    }()
    @objc
    private func updateSurname(_ textField: OutlinedTextField) {
        self.viewModel.surname = textField.text ?? ""
    }
    
    // MARK: Email setup
    
    private lazy var emailTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.email, placeholderText: R.string.registerScreenStrings.email(), selector: #selector(updateEmail(_:)))
    }()
    @objc
    func updateEmail(_ textField: OutlinedTextField) {
        self.viewModel.email = textField.text ?? ""
    }
    
    // MARK: Password setup
    
    private lazy var passwordTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: true, passwordEye: passwordEye)
        return textField.getOutlinedTextField(text: viewModel.password, placeholderText: R.string.registerScreenStrings.password(), selector: #selector(updatePassword(_:)))
    }()
    private lazy var passwordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: SystemImages.eyeSlash)!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(.redColor), for: .normal)
        eye.setImage(UIImage(systemName: SystemImages.eye)!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(.redColor), for: .selected)
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
        return textField.getOutlinedTextField(text: viewModel.confirmPassword, placeholderText: R.string.registerScreenStrings.confirm_password(), selector: #selector(updateConfirmPassword(_:)))
    }()
    private lazy var confirmPasswordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: SystemImages.eyeSlash)!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(.redColor), for: .normal)
                     eye.setImage(UIImage(systemName: SystemImages.eye)!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(.redColor), for: .selected)
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
        return button.getOutlinedButton(label: R.string.registerScreenStrings.already_have_account(), selector: #selector(goToLoginScreen))
    }()
    @objc
    func goToLoginScreen() {
        self.viewModel.loginButtonTapped()
    }
    
    // MARK: Register setup
    
    private lazy var registerButton: FilledButton = {
        let button = FilledButton()
        return button.getFilledButton(label: R.string.registerScreenStrings.register(), selector: #selector(goToMainScreen))
    }()
    @objc
    func goToMainScreen() {
        self.setupActivityIndicator()
        viewModel.register { success in
            if(success) {
                self.viewModel.createFavouritesCollection { success in
                    if(success) {
                        self.stopActivityIndicator()
                        self.viewModel.coordinator.goToMainScreen()
                    }
                    else {
                        self.showAlert(title: R.string.registerScreenStrings.create_favourites_failed(), message: self.viewModel.error)
                    }
                }
            }
            else {
                self.stopActivityIndicator()
                self.showAlert(title: R.string.registerScreenStrings.register_failed(), message: self.viewModel.error)
            }
        }
    }
    
}

extension UIView {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.loginScreenStrings.ok(), style: .default, handler: { _ in
            if message == R.string.errors.unauthorized() {
                self.validateUser()
            }
        }))
        if let viewController = self.next as? UIViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    func validateUser() {
        self.setupActivityIndicator()
        TokenManager.shared.clearAllData()
        UserDataManager.shared.clearAllData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.stopActivityIndicator()
            if let sceneDelegate = UIApplication.shared.delegate as? SceneDelegate {
                sceneDelegate.appCoordinator?.goToAuth()
                if let viewController = self.next as? UIViewController {
                    viewController.navigationController?.setViewControllers([], animated: true)
                }
            }
        }
    }
}
