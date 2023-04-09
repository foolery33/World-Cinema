//
//  RegisterScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import Foundation

class RegisterScreenViewModel {

    private var authRepository: AuthRepository
    private var collectionsRepository: CollectionsRepository
    private var collectionsDatabase: CollectionsDatabase
    weak var coordinator: AuthCoordinator!
    
    init(authRepository: AuthRepository, collectionsRepository: CollectionsRepository, collectionsDatabase: CollectionsDatabase) {
        self.authRepository = authRepository
        self.collectionsRepository = collectionsRepository
        self.collectionsDatabase = collectionsDatabase
    }
    
    var name: String = ""
    var surname: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var error: String = ""
    
    func loginButtonTapped() {
        self.coordinator.navigationController.popViewController(animated: true)
    }
    
    func register(completion: @escaping (Bool) -> Void) {
        
        if let error = GetRegisterErrorUseCase().getError(name: name, surname: surname, email: email, password: password, confirmPassword: confirmPassword) {
            self.error = error
            completion(false)
            return
        }
        authRepository.register(email: email, password: password, firstName: name, lastName: surname) { [weak self] result in
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
    
    func createFavouritesCollection(completion: @escaping (Bool) -> Void) {
        collectionsRepository.createCollection(collectionName: "Избранное") { [weak self] result in
            switch result {
            case .success(let data):
                self?.collectionsDatabase.createCollection(id: data.collectionId, name: "Избранное", imageName: "Group 1")
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
