//
//  TableViewCell.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var ownersImage: UIImageView!
    @IBOutlet private weak var authorsFullName: UILabel!
    @IBOutlet private weak var languageName: UILabel!
    @IBOutlet private weak var languageImage: UIImageView!
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var forkLabel: UILabel!
    @IBOutlet private weak var projectNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func congigureCell(authorsName: String, language: String, projectName: String, descriptionProject: String){
        authorsFullName.text = authorsName
        languageName.text = language
        projectNameLabel.text = projectName
        descriptionLabel.text = descriptionProject
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
