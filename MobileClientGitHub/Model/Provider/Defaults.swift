//
//  Defaults.swift
//  MobileClientGitHub
//
//  Created by Sergey on 18.11.2021.
//

import Foundation

class Defaults {
//    enum defaultsKeys: String {
//        case keyModel = "model"
//    }
    
    
    let defaults = UserDefaults.standard
    
    
    func get(key: String) -> String?{
        return defaults.string(forKey: key)
    }
    
    
    func set(key: String, value: [String:Int]) {
        defaults.set(value, forKey: key)
    }
}
