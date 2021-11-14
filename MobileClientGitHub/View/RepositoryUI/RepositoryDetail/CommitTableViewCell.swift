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
        // Initialization code
    }
    
    
    func initialize(VM: CommitCellVM){
        self.VM = VM
        self.VM.UI = self
        VM.updateUI()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
