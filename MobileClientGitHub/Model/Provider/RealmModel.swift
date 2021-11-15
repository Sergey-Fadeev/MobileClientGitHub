//
//  RealmModel.swift
//  MobileClientGitHub
//
//  Created by Sergey on 14.11.2021.
//

import Foundation
import RealmSwift


class RepositoryRealm: Object{
    
    @Persisted var id: Int
    @Persisted var json: Data
    @Persisted var owner: OwnerRealm
    
    @Persisted var detailInfo: Data? = nil
    
    
    @Persisted var commits: List<CommitRealm>//list<объекты релм>
    
    
    init(model: RepositoryModel) {
        super.init()
        
        self.id = model.json.id!
        
        self.json = try! JSONSerialization.data(withJSONObject: model.json)
        self.owner = OwnerRealm.init(model: model.owner)
        
        if let detailInfo = model.detailInfo{
            self.detailInfo = try! JSONSerialization.data(withJSONObject: detailInfo)
        }
        
        if let commits = model.commits{
            let commitsJSON = commits.map({return CommitRealm.init(model: $0)})
            self.commits = .init()
            self.commits.append(objectsIn: commitsJSON)
        }
    }
    
    
    func toModel() -> RepositoryModel{
        let jsonObject = try! JSONSerialization.jsonObject(with: json) as! ElementJSON
        let model = RepositoryModel.init(json: jsonObject)
        model.owner.avatar = owner.avatar
        model.commits = Array(_immutableCocoaArray: commits)
        
        return model
    }
}


class OwnerRealm: Object{
    @Persisted var json: Data
    
    
    @Persisted var avatar: Data? = nil
    
    
    init(model: OwnerModel) {
        self.json = try! JSONSerialization.data(withJSONObject: model.json)
        self.avatar = model.avatar
    }
}


class CommitRealm: Object{
    @Persisted var json: Data
    
    
    @Persisted var avatar: Data?
    
    
    init(model: CommitModel) {
        self.json = try! JSONSerialization.data(withJSONObject: model.json)
        
        if let avatar = model.avatar{
            self.avatar = try! JSONSerialization.data(withJSONObject: avatar)
        }
    }
}


