//
//  TokenManager.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 24.03.2023.
//

import Foundation
import SwiftKeychainWrapper

class TokenManager {
    
    private enum KeysName {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }
    
    static let shared: TokenManager = TokenManager()
    
    func fetchAccessToken() -> String {
        KeychainWrapper.standard.string(forKey: KeysName.accessToken) ?? ""
    }
    func fetchRefreshToken() -> String {
        KeychainWrapper.standard.string(forKey: KeysName.refreshToken) ?? ""
    }
    func saveAccessToken(accessToken: String) {
        KeychainWrapper.standard.set(accessToken, forKey: KeysName.accessToken)
    }
    func saveRefreshToken(refreshToken: String) {
        KeychainWrapper.standard.set(refreshToken, forKey: KeysName.refreshToken)
    }
    
    func clearAllData() {
        KeychainWrapper.standard.set("", forKey: KeysName.accessToken)
        KeychainWrapper.standard.set("", forKey: KeysName.refreshToken)
    }
    
}
