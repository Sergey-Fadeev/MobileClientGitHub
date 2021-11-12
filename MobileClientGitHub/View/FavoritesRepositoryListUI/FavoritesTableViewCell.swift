//
//  FavoritesTableViewCell.swift
//  MobileClientGitHub
//
//  Created by Sergey on 12.11.2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var languageImage: UIImageView!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var projectName: UILabel!
    
    @IBOutlet weak var projectDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ownerName.text = "Иванов Иван Иванович"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
