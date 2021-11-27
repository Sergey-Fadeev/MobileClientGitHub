//
//  RepositoryListVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import Foundation
import UIKit
import Combine

class RepositoryListVM {
    
    @Published var repositoryList: [RepositoryModel]? = nil
    var repositoryListCancellable: Cancellable? = nil
    
    init(model: [RepositoryModel]?) {
        if let model = model{
            repositoryList = model
        }
        repositoryListCancellable = Model.shared
            .objectWillChange
            .sink(receiveValue: {[weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.repositoryList = Model.shared.repositoriesList
                }
            })
        addRepositories()
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
    
    func VMforRowAt(indexPath: IndexPath) -> RepositoryCellVM? {
        if repositoryList != nil{
            let model = (repositoryList?[indexPath.row])!
            let vm = RepositoryCellVM.init(model: model)
            return vm
        }
        else{
            return nil
        }
    }
    
    func addRepositories(){
        Model.shared.initializeRepositories()
    }
}
