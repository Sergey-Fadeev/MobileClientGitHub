//
//  RepositoryListVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import Foundation
import Combine



class RepositoryListVM: ObservableObject {
    
    var repositoryListCancellable: Cancellable? = nil
    
    @Published var repositoryList: RepositoriesList?
    
    
//    init(model: RepositoriesModel) {
//        weatherSingleton.repositoriesList = model.repositoriesList
//        repositoryListCancellable = model
//            .objectWillChange
//            .sink(){ [self] in
//                repositoryList? = model.repositoriesList!
//            }
//    }
    
    
    init(model: RepositoriesModel) {
        repositoryListCancellable = weatherSingleton
            .objectWillChange
            .sink(){ [self] in
                repositoryList? = weatherSingleton.repositoriesList!
            }
    }
    
    
    func addRepositories(){
        weatherSingleton.addRepo()
    }
}
