//
//  Auth.swift
//  MobileClientGitHub
//
//  Created by Sergey on 18.11.2021.
//

import Foundation
import RealmSwift

class Auth {
    
    let realm = try! Realm()
    
    func registration(name: String, password: String){
        let objectInRealmCount: Int = Array(realm.objects(RepositoryRealmObject.self)).count
        Defaults().set(key: name, value: [password : objectInRealmCount + 1])
    }
    
    func containsInUserDefaults(name: String) -> Bool{
        guard Defaults().containsInUserDefaults(name: name) else{
            return false
        }
        return true
    }
    
    func changeStatus(entryStatus: Bool){
        entryStatus == true ? Defaults().set(key: "entryStatus", value: ["entryStatus" : 1]) : Defaults().set(key: "entryStatus", value: ["entryStatus" : 0])
            Defaults().set(key: "entryStatus", value: ["entryStatus" : 1])
    }
    
    func setUpUser(name: String){
        Defaults().setUpAuser(name: name)
    }
}
