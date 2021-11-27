//
//  FavoritesTableViewCell.swift
//  MobileClientGitHub
//
//  Created by Sergey on 12.11.2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet private weak var ownerImage: UIImageView!
    @IBOutlet private weak var ownerName: UILabel!
    @IBOutlet private weak var languageImage: UIImageView!
    @IBOutlet private weak var languageName: UILabel!
    @IBOutlet private weak var forksCount: UILabel!
    @IBOutlet private weak var starsCount: UILabel!
    @IBOutlet private weak var projectName: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    
    var viewModel: FavoriteRepositoryCellVM!
    var repositoryID: Int? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel = .init()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        viewModel.deleteFromFavorites(repositoryID: repositoryID!)
    }
    
    func configureCell(ownerName: String?, projectName: String?, ownerImage: Data?, languageName: String?, starsCount: Int?, forksCount: Int?, projectDescription: String?, repositoryID: Int?){
        
        self.repositoryID = repositoryID
        self.ownerName.text = ownerName ?? ""
        self.projectName.text = projectName ?? ""
        
        self.ownerImage.image = UIImage(data: ownerImage!) ?? UIImage(named: "avatar")
        self.ownerImage.layer.cornerRadius = self.ownerImage.frame.size.width / 2 - 10
        self.ownerImage.clipsToBounds = true
        
        self.languageName.text = "  " + (languageName ?? "")
        self.projectDescription.text = projectDescription ?? ""
        if starsCount != nil{
            self.starsCount.text = "  " + String(starsCount!)
        }else{
            self.starsCount.text = ""
        }
        if forksCount != nil{
            self.forksCount.text = " " + String(forksCount!)
        }else{
            self.forksCount.text = ""
        }
        
        switch languageName {
        case "JavaScript":
            languageImage.image = UIImage.init(named: "javaScript")
        case "Ruby":
            languageImage.image = UIImage.init(named: "ruby")
        default:
            languageImage.image = UIImage.init(named: "empty")
        }
    }
    
}
