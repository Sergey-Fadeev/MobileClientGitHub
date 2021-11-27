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
    
    var viewModel: RepositoryDetailVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        initUI()
    }
    
    
    func initialize(VM: RepositoryDetailVM){
        self.viewModel = VM
        VM.delegate = self
        self.viewModel.initialize()
    }
    
    
    func initUI(){
        switch viewModel.language {
        case "JavaScript":
            languageImage.image = UIImage.init(named: "javaScript")
        case "Ruby":
            languageImage.image = UIImage.init(named: "ruby")
        default:
            languageImage.image = UIImage.init(named: "empty")
        }
        
        authorsFullName.text = viewModel.login
        projectNameLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        ownersImageView.image = viewModel.avatar
        
        ownersImageView.layer.cornerRadius = ownersImageView.frame.size.width / 2
        ownersImageView.clipsToBounds = true
        
        languageName.text = "  " + viewModel.language
        starLabel.text = "  " + viewModel.starCount
        forkLabel.text = " " + viewModel.forkCount
    }
}


extension RepositoryDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(viewModel.commits.count, 10)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commitCustomCell") as! CommitTableViewCell
        let cellModel = viewModel.cellModel(at: indexPath)!
        let VM = CommitCellVM.init(model: cellModel)
        cell.initialize(VM: VM)
        return cell
    }
}


extension RepositoryDetailVC: RepositoryDetailViewModelDelegate{
    func ownerHasChanged() {
        self.ownersImageView.image = viewModel.avatar
        
        self.languageName.text = self.viewModel.language
        self.starLabel.text = self.viewModel.starCount
        self.forkLabel.text = self.viewModel.forkCount
    }
    
    
    func commitsHasChanged() {
        tableView.delegate = self
        tableView.register(UINib(nibName: "CommitTableViewCell", bundle: nil), forCellReuseIdentifier: "commitCustomCell")
        tableView.dataSource = self
        
        self.tableView.reloadData()
    }
}
