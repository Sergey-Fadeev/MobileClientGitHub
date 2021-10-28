//
//  RepositoryListVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import Foundation
import Combine



class RepositoryListVM: ObservableObject {
    
    
    @Published var repositoryList: RepositoriesList?
    var repositoryListCancellable: Cancellable? = nil
    
    
    init(model: RepositoriesModel) {
        
        repositoryList = model.repositoriesList
        repositoryListCancellable = repositoriesSingleton
            .objectWillChange
            .sink(receiveValue: {[weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.repositoryList = model.repositoriesList
                }
            })
    }
    
    
    func addRepositories(){
        repositoriesSingleton.addRepo()
    }
}
