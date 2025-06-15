//
//  AppDelegate.swift
//  Solar-Wind-iOS-app
//
//  Created by Даша Николаева on 09.06.2025.
//

import UIKit
import Scenes
import CommonUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = NavigationController(rootViewController: WelcomeBuilder.build())
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}

