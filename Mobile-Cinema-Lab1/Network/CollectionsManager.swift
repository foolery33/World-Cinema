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
    
    func setCollection(collectionId: String, imageName: String) {
        keychain.set(imageName, forKey: collectionId)
    }
    func fetchCollection(collectionId: String) -> String {
        keychain.string(forKey: collectionId) ?? ""
    }
    func removeCollection(collectionId: String) {
        keychain.remove(forKey: KeychainWrapper.Key(rawValue: collectionId))
    }
    func clearData() {
        keychain.removeAllKeys()
    }
}
