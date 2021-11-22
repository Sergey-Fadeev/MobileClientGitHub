//
//  Auth.swift
//  MobileClientGitHub
//
//  Created by Sergey on 18.11.2021.
//

import Foundation

class Auth {
    
    func registration(name: String, password: String){
        let objectInRealmCount: Int = Array(realm.objects(RepositoryRealmObject.self)).count
        Defaults().set(key: name, value: [password : objectInRealmCount + 1])
    }

    func containsInUserDefaults(name: String) -> Bool{
        if Defaults().containsInUserDefaults(name: name){
            return true
        }
        else{
            return false
        }
    }
    
    func changeStatus(entryStatus: Bool){
        if entryStatus == true{
            Defaults().set(key: "entryStatus", value: ["entryStatus" : 1])
        }
        else{
            Defaults().set(key: "entryStatus", value: ["entryStatus" : 0])
        }
    }
    
    func setUpUser(name: String){
        Defaults().setUpAuser(name: name)
    }
}
