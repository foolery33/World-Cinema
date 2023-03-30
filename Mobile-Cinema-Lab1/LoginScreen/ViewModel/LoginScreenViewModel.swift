//
//  LoginScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import Foundation

class LoginScreenViewModel {

    weak var coordinator: AuthCoordinator!
    private var authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    var email: String = ""
    var password: String = ""
    var error: String = ""
    
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

        authRepository.login(email: email, password: password) { [weak self] result in
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
