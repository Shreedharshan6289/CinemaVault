//
//  AppDelegate.swift
//  CinemaVault
//
//  Created by Apple on 25/10/25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let launch = UINavigationController(rootViewController: HomeVC())
        launch.navigationBar.isHidden = true
        self.window?.rootViewController = launch
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

