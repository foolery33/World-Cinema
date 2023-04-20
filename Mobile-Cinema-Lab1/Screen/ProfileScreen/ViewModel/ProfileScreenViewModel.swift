//
//  ProfileScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import Foundation

final class ProfileScreenViewModel {
    
    weak var coordinator: ProfileCoordinator!
    private var model = ProfileScreenModel()
    private var profileRepository: ProfileRepository
    
    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    var profile: UserModel {
        get {
            model.profile
        }
        set {
            model.profile = newValue
        }
    }
    
    var error: String = ""
    
    func leaveAccount() {
        TokenManager.shared.clearAllData()
        UserDataManager.shared.clearAllData()
        coordinator.goToLoginScreen()
    }
    
    func getProfile(completion: @escaping (Bool) -> Void) {
        profileRepository.getProfile { [weak self] result in
            switch result {
            case .success(let data):
                self?.profile = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func setAvatar(imageData: Data, completion: @escaping (Bool) -> Void) {
        profileRepository.setAvatar(imageData: imageData) { [weak self] result in
            switch result {
            case .success:
                print("Successfully uploaded avatar")
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func goToChatListScreen() {
        self.coordinator.goToChatListScreen()
    }
    
}
