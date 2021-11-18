//
//  RepositoryDetailCellVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 14.11.2021.
//

import Foundation
import UIKit
import Combine


class CommitCellVM {
    
    let model: CommitModel
    
    
    weak var UI: CommitTableViewCell!
    
    
    private var avatalCancellable: Cancellable? = nil
    
    
    init(model: CommitModel) {
        self.model = model
        
        avatalCancellable = model
            .objectWillChange
            .sink{ [self]_ in
                DispatchQueue.main.async { [weak self] in
                    if self != nil{
                        self!.UI.authorAvatar.image = avatar
                    }
                }
            }
    }
    
    
    var authorName: String{
        if let value = model.json.author?.login{
            return String(value)
        }
        else{
            return ""
        }
    }
    
    
    var commitDescription: String{
        if let value = model.json.commit?.message{
            return String(value)
        }
        else{
            return ""
        }
    }
    
    
    var commitDate: String{
        if let value = model.json.commit?.author.date{
            return String(value)
        }
        else{
            return ""
        }
    }
    
    
    var avatar: UIImage{
        if let avatar = model.avatar{
            return UIImage.init(data: avatar)!
        }
        else{
            return UIImage(named: "github")!
        }
    }
    
    
    func updateUI(){
        loadAvatar()
        
        UI.authorName.text = authorName
        UI.commitDescription.text = commitDescription
        UI.commitDate.text = commitDate
        UI.authorAvatar.image = avatar
        
        UI.authorAvatar.layer.cornerRadius = UI.authorAvatar.frame.size.width / 2
        UI.authorAvatar.clipsToBounds = true
    }
    
    
    func loadAvatar(){
        if !model.avatarLoaded{
            model.loadAvatar()
        }
    }
}
