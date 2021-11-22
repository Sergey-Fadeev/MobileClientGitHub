//
//  Defaults.swift
//  MobileClientGitHub
//
//  Created by Sergey on 18.11.2021.
//

import Foundation

class Defaults {
    
    let defaults = UserDefaults.standard
    
    func get(key: String) -> [String:Any]{
        userLogin = key
        return defaults.dictionary(forKey: key)!
    }
    
    func set(key: String, value: [String:Int]) {
        defaults.set(value, forKey: key)
    }
    
    func setUpAuser(name: String){
        if containsInUserDefaults(name: name){
            UserDefaults.standard.removeObject(forKey: "user")
            UserDefaults.standard.set(name, forKey: "user")
        }
        else{
            defaults.set(name, forKey: "user")
        }
    }
    
    func containsInUserDefaults(name: String) -> Bool{
        if defaults.object(forKey: name) != nil{
            return true
        }
        else{
            return false
        }
    }
}
