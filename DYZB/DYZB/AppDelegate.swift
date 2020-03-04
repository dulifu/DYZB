//
//  AppDelegate.swift
//  DYZB
//
//  Created by apple on 2020/2/28.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            window = UIWindow.init()
            window?.backgroundColor = .white
            window?.frame = UIScreen.main.bounds
            let tabbarController = MainTabBarController.init()
            window?.rootViewController = tabbarController
            window?.makeKeyAndVisible()
        return true
    }

}
