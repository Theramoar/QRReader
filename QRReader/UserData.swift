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
            print("New API Key was set!")
            userDefaults.setValue(savedAPIKey, forKey: UserData.cachedAPIKey)
        }
    }
    
    var soundEnabled: Bool {
        didSet {
            print("New Sound Option was set! - \(soundEnabled)")
            userDefaults.setValue(soundEnabled, forKey: UserData.cachedSoundOption)
        }
    }
    
    
    private static let cachedAPIKey  = "cachedAPIKey"
    private static let cachedSoundOption = "cachedSoundOption"
}
