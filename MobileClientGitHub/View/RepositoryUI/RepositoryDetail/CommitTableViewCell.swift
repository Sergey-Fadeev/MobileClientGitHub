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
    
    var viewModel: CommitCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(VM: CommitCellVM){
        self.viewModel = VM
        self.viewModel.delegate = self
        initUI()
    }
    
    func initUI(){
        authorName.text = viewModel.authorName
        commitDescription.text = viewModel.commitDescription
        commitDate.text = viewModel.commitDate
        authorAvatar.image = viewModel.avatar
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
            authorAvatar.image = viewModel.avatar
        }
        else{
            authorAvatar.image = UIImage.init(named: "avatar")
        }
    }
}
