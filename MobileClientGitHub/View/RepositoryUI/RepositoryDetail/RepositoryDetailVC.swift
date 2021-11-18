//
//  RepositoryDetailVC.swift
//  MobileClientGitHub
//
//  Created by Sergey on 12.11.2021.
//

import UIKit

class RepositoryDetailVC: UIViewController {

    @IBOutlet weak var ownersImageView: UIImageView!
    @IBOutlet weak var authorsFullName: UILabel!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var languageImage: UIImageView!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var VM: RepositoryDetailVM!
    
    
    func initialize(VM: RepositoryDetailVM){
        self.VM = VM
        self.VM.UI = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tableView.delegate = self
        tableView.register(UINib(nibName: "CommitTableViewCell", bundle: nil), forCellReuseIdentifier: "commitCustomCell")
        tableView.dataSource = self
        
        VM.updateUI()
    }
}


extension RepositoryDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(VM.commits.count, 10)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commitCustomCell") as! CommitTableViewCell
        
        let cellModel = VM.cellModel(at: indexPath)!
        let VM = CommitCellVM.init(model: cellModel)
        cell.initialize(VM: VM)
        
        
        return cell
    }
}
