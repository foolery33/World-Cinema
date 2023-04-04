//
//  ProfileRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import Foundation

protocol ProfileRepository {
    
    func getProfile(completion: @escaping (Result<UserModel, AppError>) -> Void)
    func setAvatar(imageData: Data, completion: @escaping (Result<Bool, AppError>) -> Void)
    
}
