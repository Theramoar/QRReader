//
//  UserData.swift
//  QRReader
//
//  Created by Misha Kuznecov on 28/01/2021.
//

import Foundation


class UserData {
    static let shared = UserData()
    private let userDefaults: UserDefaults
    private init() {
        userDefaults = .standard
        savedAPIKey = userDefaults.string(forKey: UserData.cachedAPIKey) ?? ""
    }
    
    var savedAPIKey: String {
        didSet {
            print("New API Key was set!")
            userDefaults.setValue(savedAPIKey, forKey: UserData.cachedAPIKey)
        }
    }
    
    
    private static let cachedAPIKey  = "cachedAPIKey"
}
