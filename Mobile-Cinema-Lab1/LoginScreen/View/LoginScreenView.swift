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
        static let passwordEyeSize = 22.0
    }
    private enum Strings {
        static let email = "E-mail"
        static let password = "Пароль"
        static let login = "Войти"
        static let register = "Регистрация"
        static let loginFailed = "Login failed"
        static let ok = "OK"
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
        setupTextFieldsStackView()
        setupButtonsStackView()
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
    
    // MARK: TextField's StackView setup
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Paddings.defaultPadding
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        return stackView
    }()
    private func setupTextFieldsStackView() {
        addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logotype.snp.bottom).offset(Paddings.betweenLogoAndEmail)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    
    // MARK: Email setup
    
    private lazy var emailTextField: OutlinedTextField = {
        let textField = OutlinedTextField(isSecured: false)
        return textField.getOutlinedTextField(text: viewModel.email, placeholderText: Strings.email, selector: #selector(updateEmail(_:)))
    }()
    @objc
    private func updateEmail(_ textField: OutlinedTextField) {
        self.viewModel.email = textField.text ?? ""
    }
    
    // MARK: Password setup
    
    private lazy var passwordTextField: OutlinedTextField = {
        let passwordTextField = OutlinedTextField(isSecured: true, passwordEye: passwordEye)
        return passwordTextField.getOutlinedTextField(text: viewModel.password, placeholderText: Strings.password, selector: #selector(updatePassword(_:)))
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
    private func updatePassword(_ textField: OutlinedTextField) {
        self.viewModel.password = textField.text ?? ""
    }
    
    // MARK: Button's StackView setup
    
    private lazy var buttonsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = Paddings.defaultPadding
        myStackView.addArrangedSubview(loginButton)
        myStackView.addArrangedSubview(registerButton)
        return myStackView
    }()
    private func setupButtonsStackView() {
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-Paddings.betweenBottomAndRegister)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    
    // MARK: Login setup
    
    private lazy var loginButton: FilledButton = {
        let button = FilledButton()
        return button.getFilledButton(label: Strings.login, selector: #selector(goToMainScreen))
    }()
    @objc
    private func goToMainScreen() {
        
        let activityIndicator = ActivityIndicator()
        addSubview(activityIndicator)
        activityIndicator.setupEdges()
        activityIndicator.startAnimating()
        
        self.viewModel.login { success in
            activityIndicator.stopAnimating()
            if(success) {
                self.viewModel.coordinator.goToMainScreen()
            }
            else {
                let alert = UIAlertController(title: Strings.loginFailed, message: self.viewModel.error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Strings.ok, style: .default))
                if let viewController = self.next as? UIViewController {
                    viewController.present(alert, animated: true, completion: nil)
                }
            }
        }
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
    
    func getActivityIndicator() -> UIView {
        let newView = UIView(frame: .zero)
        newView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        newView.alpha = 0.0
        newView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let indicator = UIActivityIndicatorView(style: .medium)
        newView.addSubview(indicator)
        indicator.color = .white
        indicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        UIView.animate(withDuration: 0.15) {
            newView.alpha = 1.0
        }
        return newView
    }
    
}

extension ActivityIndicator {
    func setupEdges() {
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.startAnimating()
    }
}

extension UIImage {
    func resizeImage(newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        let targetSize = CGSize(width: newWidth, height: newHeight)
        
        let widthScaleRatio = targetSize.width / self.size.width
        let heightScaleRatio = targetSize.height / self.size.height
        
        let scaleFactor = min(widthScaleRatio, heightScaleRatio)
        
        let scaledImageSize = CGSize(width: self.size.width * scaleFactor, height: self.size.height * scaleFactor)
        
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
        return scaledImage
    }
}
