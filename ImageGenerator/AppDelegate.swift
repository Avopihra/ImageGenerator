//
//  AppDelegate.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setInitialViewController()
        return true
    }
    
// MARK: - Set Initial View Controller
    private func setInitialViewController() {
        let controller = GeneratorViewController.create()
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
}

