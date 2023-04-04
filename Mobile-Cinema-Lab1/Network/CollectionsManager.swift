//
//  CollectionsManager.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import SwiftKeychainWrapper

class CollectionsManager {
    
    let keychain = KeychainWrapper.standard
    
    static let shared: CollectionsManager = CollectionsManager()
    
    func setCollection(collectionName: String, imageName: String) {
        keychain.set(imageName, forKey: collectionName)
    }
    func fetchCollection(collectionName: String) -> String {
        keychain.string(forKey: collectionName) ?? ""
    }
    func removeCollection(collectionName: String) {
        keychain.remove(forKey: KeychainWrapper.Key(rawValue: collectionName))
    }
    func clearData() {
        keychain.removeAllKeys()
    }
}
