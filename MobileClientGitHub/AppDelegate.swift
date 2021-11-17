//
//  AppDelegate.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit
import Firebase

let modelSingleton = Model()
let userLogin: String = "Serega"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }
}

