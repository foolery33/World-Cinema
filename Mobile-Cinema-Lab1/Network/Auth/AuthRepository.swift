//
//  File.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

protocol AuthRepository {
    
    func login(email: String, password: String, completion: @escaping (Result<AuthTokenPairModel, AppError>) -> Void)
    func register(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<AuthTokenPairModel, AppError>) -> Void)
    
}
