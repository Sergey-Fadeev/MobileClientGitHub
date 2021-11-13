//
//  RepositoriesModel.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import Foundation
import Combine



class Model: ObservableObject {
    
    var provider = Provider()
    var providerCancellable: Cancellable? = nil
    
    @Published var repositoriesList: [RepositoryModel]? = nil
    
    
    init() {
    }
    
    
    func initializeRepositories() {
        
        let repositoriesPublisher = provider.fetchRepositories()
        providerCancellable = repositoriesPublisher.sink(receiveValue: { [self]
            jsonResult in
            guard jsonResult != nil else {
                print("\(#function) Error")
                return
            }
            
            let fullListRepo = jsonResult!.map({
                return RepositoryModel.init(json: $0)
            })
            
            self.repositoriesList = fullListRepo
        })
    }
}
