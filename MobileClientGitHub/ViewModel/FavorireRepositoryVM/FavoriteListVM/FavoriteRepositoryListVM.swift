//
//  FavoriteListVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 15.11.2021.
//

import Foundation
import Combine
import RealmSwift


class FavoriteRepositoryListVM: ObservableObject {
    
    let realm = try! Realm()
    let provider = Provider()
    @Published var repositoryList: List<RepositoryRealm>? = nil
    var notificationToken: NotificationToken? = nil

    init() {
        let results = realm.objects(RepositoryRealmObject.self)
        notificationToken = results.observe { _ in
            self.getRepositoryList()
        }
    }
    
    func getRepositoryList(){
        repositoryList = self.provider.getRepositories()
    }
}
