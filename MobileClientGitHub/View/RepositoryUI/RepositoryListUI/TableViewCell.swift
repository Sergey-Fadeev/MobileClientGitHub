//
//  TableViewCell.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit
import Combine

class TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var ownersImageView: UIImageView!
    @IBOutlet private weak var authorsFullName: UILabel!
    @IBOutlet private weak var languageName: UILabel!
    @IBOutlet private weak var languageImage: UIImageView!
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var forkLabel: UILabel!
    @IBOutlet private weak var projectNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var VM: RepositoryCellVM!
    var VMCancellable: Cancellable? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    func initialize(VM: RepositoryCellVM){
        self.VM = VM
        updateUI(ownerName: VM.model.owner.json.login, avatarStringURL: VM.model.owner.json.avatarURL, title: VM.model.json.name, description: VM.model.json.description, fullNameRepository: VM.model.json.fullName)
    }
    
    
    private func updateUI(ownerName: String?, avatarStringURL: String?, title: String?, description: String?, fullNameRepository:String?){
        self.authorsFullName.text = ownerName
        self.languageName.text = "Swift"
        self.projectNameLabel.text = title
        self.descriptionLabel.text = description
        
        if let data = VM.model.owner.avatar {
            self.ownersImageView.image = UIImage.init(data: data)

        }
        else{
            self.ownersImageView.image = nil                  //загрузка аватара

            VM.addAvatar(avatarStringURL: avatarStringURL!)

            VMCancellable = VM.model.owner
                .objectWillChange
                .sink{ [self]_ in
                    DispatchQueue.main.async { [weak self] in
                        if self != nil{
                            self!.ownersImageView.image = UIImage.init(data: VM.model.owner.avatar!)
                        }
                    }
                }
        }
        
        
        if let data = VM.model.owner.detailInfo {
            self.languageName.text = data.language
            self.starLabel.text = String(data.stargazersCount!)
            self.forkLabel.text = String(data.forksCount!)
        }
        else{
            self.languageName.text = nil                   //pагрузка детальной информации
            VM.addDetailInfo(fullNameRepository: fullNameRepository!)
            
            VMCancellable = VM.model.owner
                .objectWillChange
                .sink{ [self]_ in
                    DispatchQueue.main.async { [weak self] in
                        if self != nil{
                            self?.languageName.text = VM.model.owner.detailInfo?.language
                            self?.starLabel.text = String(VM.model.owner.detailInfo?.stargazersCount! ?? 0)
                            self?.forkLabel.text = String(VM.model.owner.detailInfo?.forksCount! ?? 0)
                        }
                    }
                }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
