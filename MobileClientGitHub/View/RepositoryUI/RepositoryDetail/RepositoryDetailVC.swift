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
    
    override func viewDidLoad() {
        VM.delegate = self
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        initUI()
    }
    
    
    func initialize(VM: RepositoryDetailVM){
        self.VM = VM
        self.VM.initialize()
    }
    
    
    func initUI(){
        switch VM.language {
        case "JavaScript":
            languageImage.image = UIImage.init(named: "javaScript")
        case "Ruby":
            languageImage.image = UIImage.init(named: "ruby")
        default:
            languageImage.image = UIImage.init(named: "empty")
        }
        
        authorsFullName.text = VM.login
        projectNameLabel.text = VM.title
        descriptionLabel.text = VM.description
        ownersImageView.image = VM.avatar
        
        ownersImageView.layer.cornerRadius = ownersImageView.frame.size.width / 2
        ownersImageView.clipsToBounds = true
        
        languageName.text = "  " + VM.language
        starLabel.text = "  " + VM.starCount
        forkLabel.text = " " + VM.forkCount
        
//        tableView.reloadData()
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



extension RepositoryDetailVC: RepositoryDetailVM_Delegate{
    func ownerHasChanged() {
        self.ownersImageView.image = VM.avatar
        
        self.languageName.text = self.VM.language
        self.starLabel.text = self.VM.starCount
        self.forkLabel.text = self.VM.forkCount
    }
    
    
    func commitsHasChanged() {
        tableView.delegate = self
        tableView.register(UINib(nibName: "CommitTableViewCell", bundle: nil), forCellReuseIdentifier: "commitCustomCell")
        tableView.dataSource = self
        
        self.tableView.reloadData()
    }
}
