//
//  RepositoriesModel.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import Foundation
import Combine



class RepositoriesModel: ObservableObject {
    
    
    var provider = Provider()
    var providerCancellable: Cancellable? = nil
    
    
    @Published var repositoriesList: RepositoriesList? = nil
    
    
    init() {
    }
    
    
    func addRepo() {
        
        let repoPublished = provider.fetchRepositories()
        providerCancellable = repoPublished.sink(receiveValue: { [self]
            jsonResult in
            
            if let fullListRepo = RepositoriesList.init(dataRepo: jsonResult){
                self.repositoriesList = fullListRepo
                print("")
                print("отработал addRepo в Model")
                print("\(self.repositoriesList!.repositoryList?.count)")
            }
            else{
                print("gvgvgvgvgv")
            }
        })
    }
    
    
//    func addRepoList() {
//        repositoriesList = provider.fetchRepositoriesList()
//    }
}
