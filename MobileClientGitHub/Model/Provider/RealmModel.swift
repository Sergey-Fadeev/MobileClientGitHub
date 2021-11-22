//
//  RealmModel.swift
//  MobileClientGitHub
//
//  Created by Sergey on 14.11.2021.
//

import Foundation
import RealmSwift


class RepositoryRealmObject: Object{
    @Persisted var userLogin: String
    @Persisted var repositoryListRealm: List<RepositoryRealm>
}


class RepositoryRealm: Object{
    
    @Persisted var id: Int
    @Persisted var authorsName: String
    @Persisted var languageName: String
    @Persisted var projectName: String
    @Persisted var projectdescription: String
    @Persisted var starsCount: Int?
    @Persisted var forksCount: Int?
    @Persisted var owner: OwnerRealm?
    @Persisted var commits: List<CommitRealm>
    
    convenience init(model: RepositoryModel) {
        self.init()
        
        self.id = model.json.id!
        self.authorsName = model.json.owner?.login ?? ""
        self.projectName = model.json.name ?? ""
        self.languageName = model.detailInfo?.language ?? ""
        self.projectdescription = model.json.description ?? ""
        self.starsCount = model.detailInfo?.stargazersCount
        self.forksCount = model.detailInfo?.forksCount
        self.owner = OwnerRealm.init(model: model.owner)
        
        if let commits = model.commits{
            let commitsJSON = commits.map({return CommitRealm.init(model: $0)})
            self.commits = .init()
            self.commits.append(objectsIn: commitsJSON)
        }
    }
}


class OwnerRealm: Object{
    
    
    @Persisted var id: Int
    @Persisted var name: String
    
    @Persisted var avatar: Data? = nil
    
    
    convenience init(model: OwnerModel) {
        self.init()
        
        self.id = model.json.id
        self.name = model.json.login
        self.avatar = model.avatar
    }
}


class CommitRealm: Object{
    
    @Persisted var nameAuthor: String
    @Persisted var commitDescription: String
    @Persisted var dateCommit: String
    
    @Persisted var avatarAuthor: Data?
    
    
    convenience init(model: CommitModel) {
        self.init()
        
        self.nameAuthor = model.json.author?.login ?? ""
        self.dateCommit = model.json.commit?.author.date ?? ""
        if let avatar = model.avatar{
            self.avatarAuthor = avatar
        }
        self.commitDescription = model.json.commit?.message ?? ""
    }
}


