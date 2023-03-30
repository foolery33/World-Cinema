//
//  GetRegisterErrorUseCase.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

class GetRegisterErrorUseCase {
    
    func getError(name: String, surname: String, email: String, password: String, confirmPassword: String) -> String? {
        
        // MARK: Empty fields validation
        if(EmptyFieldValidation().isEmptyField(name) ||
           EmptyFieldValidation().isEmptyField(surname) ||
           EmptyFieldValidation().isEmptyField(email) ||
           EmptyFieldValidation().isEmptyField(password) ||
           EmptyFieldValidation().isEmptyField(confirmPassword)) {
            return AppError.authError(.emptyField).errorDescription
        }
        
        // MARK: Passwords equality validation
        if(!PasswordsEquality().areEqualPasswords(password, confirmPassword)) {
            return AppError.authError(.differentPasswords).errorDescription
        }
        
        // MARK: Email pattern validation
        if(!EmailValidation().isValidEmail(email)) {
            return AppError.authError(.invalidEmail).errorDescription
        }
        
        return nil
    }
    
}
