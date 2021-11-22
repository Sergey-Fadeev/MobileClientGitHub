//
//  DetailTableViewCell.swift
//  MobileClientGitHub
//
//  Created by Sergey on 12.11.2021.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var commitDescription: UILabel!
    @IBOutlet weak var commitDate: UILabel!
    @IBOutlet weak var authorAvatar: UIImageView!
    
    var VM: CommitCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateUI()
    }
    
    func initialize(VM: CommitCellVM){
        self.VM = VM
        self.VM.delegate = self
    }
    
    
    func updateUI(){
        authorName.text = VM.authorName
        commitDescription.text = VM.commitDescription
        commitDate.text = VM.commitDate
        authorAvatar.image = VM.avatar
        authorAvatar.layer.cornerRadius = authorAvatar.frame.size.width / 2
        authorAvatar.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension CommitTableViewCell: CommitCellVM_Delegate{
    func avatarHasChanged() {
        if authorAvatar.image != nil{
            authorAvatar.image = VM.avatar
        }
        else{
            authorAvatar.image = UIImage.init(named: "avatar")
        }
    }
}
