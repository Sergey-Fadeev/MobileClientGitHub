//
//  Provider.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import Foundation
import Combine
import RealmSwift

let realm = try! Realm()

class Provider {
    
    private let mainURL = URL(string: "https://Vasiliy-Vasilyev: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@api.github.com/repositories")
    private let detailInfoURL = "https://Vasiliy-Vasilyev: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@api.github.com/repos/"
    
    private func absoluteURL(fullName: String) -> URL? {
        let queryURL = URL(string: detailInfoURL + fullName)!
        
        return queryURL
    }
    
    func fetchRepositories() -> AnyPublisher<FullJSON, Never> {
        guard let url = mainURL else {
            return Just(FullJSON.none)
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .decode(type: FullJSON.self, decoder: JSONDecoder())
            .catch { error in Just(FullJSON.none)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchAvatar(avatarStringURL: String?) -> AnyPublisher<Data, Never> {
        guard avatarStringURL != nil, let url = URL.init(string: avatarStringURL!) else {
            return Just(Data())
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .catch { error in Just(Data())}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchDetailInfo(fullNameRepository: String?) -> AnyPublisher<DetailJSON, Never> {
        
        let baseURL: String = "https://Vasiliy-Vasilyev:33KAlyAminA1922@api.github.com/repos/"
        
        guard fullNameRepository != nil, let url = URL.init(string: baseURL + fullNameRepository!) else {
            return Just(DetailJSON.placeholder)
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .decode(type: DetailJSON.self, decoder: JSONDecoder())
            .catch { error in Just(DetailJSON.placeholder)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCommits(fullNameRepository: String?) -> AnyPublisher<CommitsJSONArray, Never> {
        
        let baseURL: String = "https://Vasiliy-Vasilyev:33KAlyAminA1922@api.github.com/repos/"
        
        guard fullNameRepository != nil, let url = URL.init(string: "\(baseURL)\(fullNameRepository!)/commits") else {
            return Just(CommitElement.placeholder)
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .decode(type: CommitsJSONArray.self, decoder: JSONDecoder())
            .catch { error in Just(CommitElement.placeholder)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func saveToFavorites(repositoryModel: RepositoryModel){
        
        var saved: Bool = false
        
        guard !realm.isEmpty else{
            let realmObject = RepositoryRealmObject()
            realmObject.userLogin = userLogin
            realmObject.repositoryListRealm.append(RepositoryRealm.init(model: repositoryModel))
            try! realm.write{
                realm.add(realmObject)
            }
            return
        }
        
        var results: Results<RepositoryRealmObject>!
        results = realm.objects(RepositoryRealmObject.self)
        
        for item in results{
            if item.userLogin == userLogin && !containsInFavorites(repositoryModel: repositoryModel){
                try! realm.write{
                    item.repositoryListRealm.append(RepositoryRealm.init(model: repositoryModel))
                }
                saved = true
            }
        }
        
        if !saved && !containsInFavorites(repositoryModel: repositoryModel){
            let realmObject = RepositoryRealmObject()
            realmObject.userLogin = userLogin
            realmObject.repositoryListRealm.append(RepositoryRealm.init(model: repositoryModel))
            try! realm.write{
                realm.add(realmObject)
            }
        }
    }
    
    func deleteFromFavorites(repositoryID: Int){
        
        guard !realm.isEmpty else{
            return
        }
        
        var results: Results<RepositoryRealmObject>!
        results = realm.objects(RepositoryRealmObject.self)
        
        for item in results{
            if item.userLogin == userLogin{
                for value in item.repositoryListRealm{
                    if value.id == repositoryID{
                        try! realm.write{
                            realm.delete(value)
                        }
                    }
                }
            }
        }
    }
    
    func getRepositories() -> List<RepositoryRealm>?{
        var results: Results<RepositoryRealmObject>!
        results = realm.objects(RepositoryRealmObject.self)
        
        var repositoriesModelArray: List<RepositoryRealm>? = nil
        
        guard !realm.isEmpty else{
            return nil
        }
        
        for item in results{
            if item.userLogin == userLogin{
                repositoriesModelArray = item.repositoryListRealm
            }
        }
        return repositoriesModelArray
    }
    
    func containsInFavorites(repositoryModel: RepositoryModel)->Bool {
        var contains: Bool = false
        var results: Results<RepositoryRealmObject>!
        results = realm.objects(RepositoryRealmObject.self)
        
        guard !realm.isEmpty else{
            return contains
        }
        for item in results {
            if item.userLogin == userLogin{
                for id in item.repositoryListRealm{
                    if id.id == repositoryModel.json.id{
                        contains = true
                    }
                }
            }
        }
        return contains
    }
}
