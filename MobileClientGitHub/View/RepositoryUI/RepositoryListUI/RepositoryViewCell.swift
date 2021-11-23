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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    func initialize(VM: RepositoryCellVM){
        self.VM = VM
        VM.delegate = self
        VM.initialise()
        initUI()
    }
    
    func initUI(){
        authorsFullName.text = VM.login
        projectNameLabel.text = VM.title
        descriptionLabel.text = VM.description
        ownersImageView.image = VM.avatar
        
        switch VM.language {
        case "JavaScript":
            languageImage.image = UIImage.init(named: "javaScript")
        case "Ruby":
            languageImage.image = UIImage.init(named: "ruby")
        default:
            languageImage.image = UIImage.init(named: "empty")
        }
        
        ownersImageView.layer.cornerRadius = ownersImageView.frame.size.width / 2 - 10
        ownersImageView.clipsToBounds = true
        
        languageName.text = "  " + VM.language
        starLabel.text = "  " + VM.starCount
        forkLabel.text = " " + VM.forkCount
        
        if !VM.containsInFavorites(){
            saveButtonOutlet.tintColor = UIColor.systemGreen
            saveButtonOutlet.setTitle("Сохранить", for: .normal)
        }
        else{
            saveButtonOutlet.tintColor = UIColor.gray
            saveButtonOutlet.setTitle("Сохранено", for: .normal)
        }
        reloadInputViews()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if !VM.containsInFavorites(){
            VM.saveToFavorites()
            saveButtonOutlet.tintColor = UIColor.gray
            saveButtonOutlet.setTitle("Сохранено", for: .normal)
        }
        else{
            VM.deleteFromFavorites()
            saveButtonOutlet.tintColor = .systemGreen
            saveButtonOutlet.setTitle("Сохранить", for: .normal)
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
