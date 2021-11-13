//
//  RepositoryListVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import Foundation
import Combine



class RepositoryListVM: ObservableObject {
    
    
    @Published var repositoryList: [RepositoryModel]?
    var repositoryListCancellable: Cancellable? = nil
    

    
    init(model: Model) {
        
        repositoryList = model.repositoriesList
        repositoryListCancellable = repositoriesSingleton
            .objectWillChange
            .sink(receiveValue: {[weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.repositoryList = model.repositoriesList
                }
            })
    }
    
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard repositoryList != nil else{
            return 0
        }
        guard repositoryList?.count != nil else{
            return 0
        }
        return repositoryList!.count
    }
    
    
    func cellForRowAt(indexPath: IndexPath) -> RepositoryModel {
        guard repositoryList != nil else{
            return RepositoryModel.init(json: ElementJSON.placeholder)
        }
        return (repositoryList?[indexPath.row])!
    }
    
    func addRepositories(){
        repositoriesSingleton.initializeRepositories()
    }
}
