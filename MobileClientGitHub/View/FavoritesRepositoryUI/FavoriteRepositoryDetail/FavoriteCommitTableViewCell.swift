//
//  FavoriteCommitTableViewCell.swift
//  MobileClientGitHub
//
//  Created by Sergey on 12.11.2021.
//

import UIKit

class FavoriteCommitTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var ownerName: UILabel!
    @IBOutlet private weak var ownerAvatar: UIImageView!
    @IBOutlet private weak var commitDescription: UILabel!
    @IBOutlet private weak var dateOfCommit: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(ownerName: String?, ownerAvatar: Data?, commitDescription: String?, dateOfCommit: String?){
        self.ownerName.text = ownerName ?? ""
        
        if ownerAvatar != nil{
            self.ownerAvatar.image = UIImage.init(data: ownerAvatar!)
        }
        else{
            self.ownerAvatar.image = UIImage.init(named: "avatar")
        }
    
        self.commitDescription.text = commitDescription ?? ""
        self.dateOfCommit.text = dateOfCommit ?? ""
        self.ownerAvatar.layer.cornerRadius = self.ownerAvatar.frame.size.width / 2
        self.ownerAvatar.clipsToBounds = true
    }
}
