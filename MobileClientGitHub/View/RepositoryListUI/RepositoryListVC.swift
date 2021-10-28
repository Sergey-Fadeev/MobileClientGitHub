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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        VM = .init(model: repositoriesSingleton)
        VM.addRepositories()
        VMCancellable = VM
            .objectWillChange
            .sink(){ [self]_ in
                DispatchQueue.main.async { [weak self] in
                    if self != nil{
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
        return (VM.repositoryList?.repositoryList?.count) ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        cell.congigureCell(authorsName: (VM.repositoryList?.repositoryList![indexPath.row].owner!.login) ?? "", language: (VM.repositoryList?.repositoryList![indexPath.row].languagesURL) ?? "", projectName: (VM.repositoryList?.repositoryList![indexPath.row].name) ?? "", descriptionProject: VM.repositoryList?.repositoryList![indexPath.row].welcomeDescription ?? "")
        return cell
    }
}

