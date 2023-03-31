//
//  GetRegisterErrorUseCase.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

class GetRegisterErrorUseCase {
    
    func getError(name: String, surname: String, email: String, password: String, confirmPassword: String) -> String? {
        
        var error = ""
        
        // MARK: Empty fields validation
        if(EmptyFieldValidation().isEmptyField(name) ||
           EmptyFieldValidation().isEmptyField(surname) ||
           EmptyFieldValidation().isEmptyField(email) ||
           EmptyFieldValidation().isEmptyField(password) ||
           EmptyFieldValidation().isEmptyField(confirmPassword)) {
            error = AppError.authError(.emptyField).errorDescription
            return error
        }
        
        // MARK: Passwords equality validation
        if(!PasswordsEquality().areEqualPasswords(password, confirmPassword)) {
            error = AppError.authError(.differentPasswords).errorDescription
            return error
        }
        
        // MARK: Email pattern validation
        if(!EmailValidation().isValidEmail(email)) {
            error = AppError.authError(.invalidEmail).errorDescription
            return error
        }
        
        return nil
    }
    
}
