//
//  AppDelegate.swift
//  QRReader
//
//  Created by Misha Kuznecov on 27/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let userData: UserData = .shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        if userData.savedAPIKey.isEmpty {
            window?.rootViewController = EnterCodeViewController()
        } else {
            let navVC = UINavigationController(rootViewController: StartViewController())
            navVC.navigationBar.prefersLargeTitles = false
            window?.rootViewController = navVC
        }
        window?.makeKeyAndVisible()
        
        return true
    }
}

