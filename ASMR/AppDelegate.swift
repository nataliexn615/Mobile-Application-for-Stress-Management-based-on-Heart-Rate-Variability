//
//  AppDelegate.swift
//  ASMR
//
//  Created by Ying Nam lee on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit    
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        UINavigationBar.appearance().barTintColor = UIColor(red: 170.0/255.0, green: 191.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = .white

        //UITabBar.appearance().tintColor = .black
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

