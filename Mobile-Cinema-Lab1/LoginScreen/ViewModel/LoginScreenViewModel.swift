//
//  LoginScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import Foundation

class LoginScreenViewModel {
    
    private var model: LoginScreenModel = LoginScreenModel()
    weak var coordinator: AuthCoordinator!
    
    var email: String {
        get {
            model.email
        }
        set {
            model.email = newValue
        }
    }
    
    var password: String {
        get {
            model.password
        }
        set {
            model.password = newValue
        }
    }
    
    var error: String {
        get {
            model.error
        }
        set {
            model.error = newValue
        }
    }
    
    func registerButtonTapped() {
        coordinator.goToRegisterScreen()
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        
        // MARK: Empty fields validation
        if(EmptyFieldValidation().isEmptyField(email) ||
           EmptyFieldValidation().isEmptyField(password)) {
            self.error = AppError.authError(.emptyField).errorDescription
            completion(false)
            return
        }

        AuthViewModel.shared.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let data):
                TokenManager.shared.saveAccessToken(accessToken: data.accessToken)
                TokenManager.shared.saveRefreshToken(refreshToken: data.refreshToken)
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
        
    }
    
}
