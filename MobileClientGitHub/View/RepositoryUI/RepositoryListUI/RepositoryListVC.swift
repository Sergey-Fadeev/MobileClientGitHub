//
//  ViewController.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit
import Combine

class RepositoryListVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    
    var VM: RepositoryListVM!
    var VMCancellable: Cancellable? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        VM = .init(model: repositoriesSingleton)
        VM.addRepositories()
        VMCancellable = VM
            .objectWillChange
            .sink(){ [self]_ in
                DispatchQueue.main.async { [weak self] in
                    if self != nil{
                        tableView.delegate = self
                        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "repositoryCustomCell")
                        self?.tableView.dataSource = self
                        tableView.reloadData()
                    }
                }
        }
    }
}


extension RepositoryListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (VM.repositoryList?.count) ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "repositoryDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCustomCell") as! TableViewCell
        
        let cellModel = VM.cellForRowAt(indexPath: indexPath)
        let cellVM = RepositoryCellVM.init(model: cellModel)
        cell.initialize(VM: cellVM)
        
        return cell
    }
}

