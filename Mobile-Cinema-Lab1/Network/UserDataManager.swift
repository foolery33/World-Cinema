//
//  UserDataManager.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import Foundation
import SwiftKeychainWrapper

final class UserDataManager {
    
    private enum KeysName {
        static let userId = "userId"
        static let favouritesCollectionId = "favouritesCollectionId"
    }
    
    static let shared: UserDataManager = UserDataManager()
    
    // UserID
    func fetchUserId() -> String {
        KeychainWrapper.standard.string(forKey: KeysName.userId) ?? ""
    }
    func saveUserId(userId: String) {
        KeychainWrapper.standard.set(userId, forKey: KeysName.userId)
    }
    
    // FavouritesCollectionID
    func fetchFavouritesCollectionId() -> String {
        KeychainWrapper.standard.string(forKey: KeysName.favouritesCollectionId) ?? ""
    }
    func saveFavouritesCollectionId(id: String) {
        KeychainWrapper.standard.set(id, forKey: KeysName.favouritesCollectionId)
    }
    
    func clearAllData() {
        KeychainWrapper.standard.removeAllKeys()
    }
    
}
