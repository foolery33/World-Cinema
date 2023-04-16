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
    }
    
    static let shared: UserDataManager = UserDataManager()
    
    func fetchUserId() -> String {
        KeychainWrapper.standard.string(forKey: KeysName.userId) ?? ""
    }
    func saveUserId(userId: String) {
        KeychainWrapper.standard.set(userId, forKey: KeysName.userId)
    }
    
    func clearAllData() {
        KeychainWrapper.standard.removeAllKeys()
    }
    
}
