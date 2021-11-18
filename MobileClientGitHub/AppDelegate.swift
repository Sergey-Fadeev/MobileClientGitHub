//
//  AppDelegate.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit

let modelSingleton = Model()
let userLogin: String = "Serega"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        showMainVC()
        return true
    }
    
    func showMainVC(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigation")
    
        appDelegate.window?.rootViewController = rootController
    }
}

