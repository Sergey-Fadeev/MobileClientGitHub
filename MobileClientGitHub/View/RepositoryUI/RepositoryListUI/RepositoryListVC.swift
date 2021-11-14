//
//  ViewController.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit


class RepositoryListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var VM: RepositoryListVM!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.VM = .init(model: modelSingleton.repositoriesList, UI: self)
    }
}


extension RepositoryListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (VM.repositoryList?.count) ?? 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailedVC = sender as! RepositoryDetailVC
        print("asasa")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "repositoryDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCustomCell") as! RepositoryViewCell
        
        let cellModel = VM.cellForRowAt(indexPath: indexPath)
        let cellVM = RepositoryCellVM.init(model: cellModel)
        cell.initialize(VM: cellVM)
        
        return cell
    }
}

