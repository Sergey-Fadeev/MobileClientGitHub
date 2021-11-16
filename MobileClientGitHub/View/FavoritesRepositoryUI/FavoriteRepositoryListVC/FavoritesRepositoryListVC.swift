//
//  FavoritesRepositoryViewController.swift
//  MobileClientGitHub
//
//  Created by Sergey on 12.11.2021.
//

import UIKit
import Combine
import RealmSwift

class FavoritesRepositoryListVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: FavoriteRepositoryListVM!
    var viewModelCancellable: Cancellable? = nil
    
    var repositoryListRealm: List<RepositoryRealm>? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = .init()
        
        
        viewModelCancellable =  viewModel?
            .objectWillChange
            .sink(receiveValue: { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.repositoryListRealm = self!.viewModel.repositoryList
                    self!.tableView.reloadData()
                }
            })
        viewModel.getRepositoryList()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "customFavoriteCell")
    }
}


extension FavoritesRepositoryListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositoryListRealm?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customFavoriteCell") as! FavoritesTableViewCell
        if repositoryListRealm != nil{
            let index = repositoryListRealm![indexPath.row]
            cell.configureCell(ownerName: index.authorsName, projectName: index.projectName, ownerImage: index.owner?.avatar, languageName: index.languageName, starsCount: index.starsCount, forksCount: index.forksCount, projectDescription: index.projectdescription)
        }
        else{
            let index = repositoryListRealm![indexPath.row]
            cell.configureCell(ownerName: nil, projectName: nil, ownerImage: nil, languageName: nil, starsCount: nil, forksCount: nil, projectDescription: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favoritesRepositoryDetail", sender: tableView.cellForRow(at: indexPath))
    }
}
