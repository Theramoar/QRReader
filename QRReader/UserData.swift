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
        soundEnabled = userDefaults.bool(forKey: UserData.cachedSoundOption)
    }
    
    var savedAPIKey: String {
        didSet {
            userDefaults.setValue(savedAPIKey, forKey: UserData.cachedAPIKey)
        }
    }
    
    var soundEnabled: Bool {
        didSet {
            userDefaults.setValue(soundEnabled, forKey: UserData.cachedSoundOption)
        }
    }
    
    
    private static let cachedAPIKey  = "cachedAPIKey"
    private static let cachedSoundOption = "cachedSoundOption"
}
