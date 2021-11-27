//
//  TableViewCell.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit


class RepositoryViewCell: UITableViewCell {
    
    @IBOutlet private weak var ownersImageView: UIImageView!
    @IBOutlet private weak var authorsFullName: UILabel!
    @IBOutlet private weak var languageName: UILabel!
    @IBOutlet private weak var languageImage: UIImageView!
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var forkLabel: UILabel!
    @IBOutlet private weak var projectNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var saveButtonOutlet: UIButton!
    
    var viewModel: RepositoryCellVM?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    func initialize(VM: RepositoryCellVM){
        self.viewModel = VM
        VM.delegate = self
        VM.initialise()
        initUI()
    }
    
    func initUI(){
        guard viewModel != nil else{return}
        authorsFullName.text = viewModel?.login
        projectNameLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        ownersImageView.image = viewModel?.avatar
        
        switch viewModel?.language {
        case "JavaScript":
            languageImage.image = UIImage.init(named: "javaScript")
        case "Ruby":
            languageImage.image = UIImage.init(named: "ruby")
        default:
            languageImage.image = UIImage.init(named: "empty")
        }
        
        ownersImageView.layer.cornerRadius = ownersImageView.frame.size.width / 2 - 10
        ownersImageView.clipsToBounds = true
        
        languageName.text = "  " + viewModel!.language
        starLabel.text = "  " + viewModel!.starCount
        forkLabel.text = " " + viewModel!.forkCount
        
        if !viewModel!.containsInFavorites(){
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
        guard viewModel != nil else{return}
        if !viewModel!.containsInFavorites(){
            viewModel!.saveToFavorites()
            saveButtonOutlet.tintColor = UIColor.gray
            saveButtonOutlet.setTitle("Сохранено", for: .normal)
        }
        else{
            viewModel?.deleteFromFavorites()
            saveButtonOutlet.tintColor = .systemGreen
            saveButtonOutlet.setTitle("Сохранить", for: .normal)
        }
    }
}


extension RepositoryViewCell: RepositoryCellVM_Delegate{
    
    
    func ownerHasChanged() {
        ownersImageView.image = viewModel?.avatar
        languageName.text = viewModel?.language
        starLabel.text = viewModel?.starCount
        forkLabel.text = viewModel?.forkCount
        switch viewModel?.language {
        case "JavaScript":
            languageImage.image = UIImage.init(named: "javaScript")
        case "Ruby":
            languageImage.image = UIImage.init(named: "ruby")
        default:
            languageImage.image = UIImage.init(named: "empty")
        }
    }
    
}
