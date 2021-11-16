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
    
    
    @IBAction func saveButton(_ sender: Any) {
        VM.saveToFavorites()
        saveButtonOutlet.backgroundColor = .gray
    }
    
    
    func initialize(VM: RepositoryCellVM){
        self.VM = VM
        self.VM.UI = self
        VM.updateUI()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
