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
    
    
    var repositoryList: [RepositoryModel]?
    var repositoryListCancellable: Cancellable? = nil
    
    
    var VMCancellable: Cancellable? = nil
    
    
    weak var UI: RepositoryListVC!
    
    
    init(model: [RepositoryModel]?, UI: RepositoryListVC) {
        repositoryList = model
        self.UI = UI
        
        repositoryListCancellable = modelSingleton
            .objectWillChange
            .sink(receiveValue: {[weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.repositoryList = modelSingleton.repositoriesList
                    
                    self?.UI.tableView.delegate = self?.UI
                    self?.UI.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "repositoryCustomCell")
                    self?.UI.tableView.dataSource = self?.UI
                    
                    self?.UI.tableView.reloadData()
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
    
    
    func cellForRowAt(indexPath: IndexPath) -> RepositoryModel {
        guard repositoryList != nil else{
            return RepositoryModel.init(json: ElementJSON.placeholder)
        }
        return (repositoryList?[indexPath.row])!
    }
    
    
    func addRepositories(){
        modelSingleton.initializeRepositories()
    }
}
