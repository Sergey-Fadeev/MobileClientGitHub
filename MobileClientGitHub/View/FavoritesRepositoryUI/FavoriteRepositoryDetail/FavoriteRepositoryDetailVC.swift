//
//  FavoriteRepositoryDetailVC.swift
//  MobileClientGitHub
//
//  Created by Sergey on 12.11.2021.
//

import UIKit
import RealmSwift

class FavoriteRepositoryDetailVC: UIViewController {

    @IBOutlet weak var imageOwner: UIImageView!
    @IBOutlet weak var nameOwner: UILabel!
    @IBOutlet weak var imageLanguage: UIImageView!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var tableViewCommit: UITableView!
    
    var viewModel: RepositoryRealm? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCommit.delegate = self
        tableViewCommit.dataSource = self
        tableViewCommit.register(UINib(nibName: "FavoriteCommitTableViewCell", bundle: nil), forCellReuseIdentifier: "favoriteCommitCell")
        
        switch viewModel?.languageName {
        case "JavaScript":
            imageLanguage.image = UIImage.init(named: "javaScript")
        case "Ruby":
            imageLanguage.image = UIImage.init(named: "ruby")
        default:
            imageLanguage.image = UIImage.init(named: "empty")
        }
        
        self.nameOwner.text = viewModel?.owner?.name
        self.projectName.text = viewModel?.projectName
        
        if viewModel?.owner?.avatar != nil{
            self.imageOwner.image = UIImage.init(data: (viewModel?.owner?.avatar)!)
        }
        else{
            self.imageOwner.image = UIImage.init(named: "avatar")
        }
        
        self.imageOwner.layer.cornerRadius = self.imageOwner.frame.size.width / 2
        self.imageOwner.clipsToBounds = true
        self.languageName.text = "  " + (viewModel?.languageName ?? "")
        if let stars = viewModel?.starsCount{
            self.starsCount.text = "  \(String(stars))"
        }
        else{
            self.starsCount.text = ""
        }
        
        if let forks = viewModel?.forksCount{
            self.forksCount.text = String(forks)
        }
        else{
            self.forksCount.text = ""
        }
        self.projectDescription.text = viewModel?.projectdescription ?? ""
    }
}


extension FavoriteRepositoryDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(viewModel?.commits.count ?? 0, 10)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewCommit.dequeueReusableCell(withIdentifier: "favoriteCommitCell") as! FavoriteCommitTableViewCell
        cell.configure(ownerName: viewModel?.commits[indexPath.row].nameAuthor, ownerAvatar: viewModel?.commits[indexPath.row].avatarAuthor, commitDescription: viewModel?.commits[indexPath.row].commitDescription, dateOfCommit: viewModel?.commits[indexPath.row].dateCommit)
        return cell
    }
}
