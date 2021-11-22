//
//  TableViewCell.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit


class RepositoryViewCell: UITableViewCell {
    
    @IBOutlet weak var ownersImageView: UIImageView!
    @IBOutlet weak var authorsFullName: UILabel!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var languageImage: UIImageView!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    var VM: RepositoryCellVM!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func initialize(VM: RepositoryCellVM){
        self.VM = VM
        VM.initialise()
        initUI()
    }
    
    
    func initUI(){
        authorsFullName.text = VM.login
        projectNameLabel.text = VM.title
        descriptionLabel.text = description
        ownersImageView.image = VM.avatar
        
        ownersImageView.layer.cornerRadius = ownersImageView.frame.size.width / 2 - 10
        ownersImageView.clipsToBounds = true
        
        languageName.text = "  " + VM.language
        starLabel.text = "  " + VM.starCount
        forkLabel.text = " " + VM.forkCount
        
        if !VM.containsInFavorites(){
            saveButtonOutlet.tintColor = UIColor.systemGreen
            saveButtonOutlet.setTitle("Add", for: .normal)
        }
        else{
            saveButtonOutlet.tintColor = UIColor.gray
            saveButtonOutlet.setTitle("Added", for: .normal)
        }
        reloadInputViews()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if !VM.containsInFavorites(){
            VM.saveToFavorites()
            saveButtonOutlet.tintColor = UIColor.gray
            saveButtonOutlet.setTitle("Добавлено", for: .normal)
        }
        else{
            VM.deleteFromFavorites()
            saveButtonOutlet.tintColor = .systemGreen
            saveButtonOutlet.setTitle("Добавить", for: .normal)
        }
    }
}


extension RepositoryViewCell: RepositoryCellVM_Delegate{
    
    
    func ownerHasChanged() {
        self.ownersImageView.image = VM.avatar
        self.languageName.text = self.VM.language
        self.starLabel.text = self.VM.starCount
        self.forkLabel.text = self.VM.forkCount
        switch self.VM.language {
        case "JavaScript":
            self.languageImage.image = UIImage.init(named: "javaScript")
        case "Ruby":
            self.languageImage.image = UIImage.init(named: "ruby")
        default:
            self.languageImage.image = UIImage.init(named: "empty")
        }
    }
    
}
