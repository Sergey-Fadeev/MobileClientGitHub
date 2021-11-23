//
//  RepositoryDetailCellVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 14.11.2021.
//

import Foundation
import UIKit
import Combine

protocol CommitCellVM_Delegate: AnyObject{
    func avatarHasChanged()
}

class CommitCellVM {
    
    let model: CommitModel
    weak var delegate: CommitCellVM_Delegate? = nil
    private var avatarCancellable: Cancellable? = nil
    
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
            return UIImage.init(named: "avatar")!
        }
    }
    
    init(model: CommitModel) {
        self.model = model
        
        avatarCancellable = model
            .objectWillChange
            .sink{ [self]_ in
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.avatarHasChanged()
                }
            }
    }
}
