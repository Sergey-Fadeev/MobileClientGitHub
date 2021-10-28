//
//  ViewController.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit
import Combine

class RepositoryListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var VM: RepositoryListVM!
    
    
    var VMCancellable: Cancellable? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
    
        VM = .init(model: weatherSingleton)
        VM.addRepositories()
        
        VMCancellable = VM
            .objectWillChange
            .sink(){ [self]_ in
                print("")
                print("отработал синк в ВС")
                print("\(VM.repositoryList?.repositoryList?.count)")
        }
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
}


extension RepositoryListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (VM.repositoryList?.repositoryList?.count) ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        return cell
    }
    
    
}

