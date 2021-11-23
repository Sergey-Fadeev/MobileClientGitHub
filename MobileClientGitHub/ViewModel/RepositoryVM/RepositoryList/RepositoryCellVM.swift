//
//  RepositoryCellVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 13.11.2021.
//

import Foundation
import UIKit
import Combine


protocol RepositoryCellVM_Delegate: AnyObject{
    func ownerHasChanged()
}

class RepositoryCellVM {
    
    let provider = Provider()
    let model: RepositoryModel
    private var avatalCancellable: Cancellable? = nil
    private var commitsCancellable: Cancellable? = nil
    private var detailInfoCancellable: Cancellable? = nil
    weak var delegate: RepositoryCellVM_Delegate? = nil
    
    var login: String{
        return model.owner.json.login
    }
    
    var title: String{
        if let title = model.json.name{
            return title
        }
        else{
            return ""
        }
    }
    
    var description: String{
        if let description = model.json.description{
            return description
        }
        else{
            return ""
        }
    }
    
    var fullName: String{
        if let fullName = model.json.fullName{
            return fullName
        }
        else{
            return ""
        }
    }
    
    var language: String{
        if let language = model.detailInfo?.language{
            return language
        }
        else{
            return ""
        }
    }
    
    var starCount: String{
        if let starCount = model.detailInfo?.stargazersCount{
            return String(starCount)
        }
        else{
            return ""
        }
    }
    
    var forkCount: String{
        if let forkCount = model.detailInfo?.forksCount{
            return String(forkCount)
        }
        else{
            return ""
        }
    }
    
    var avatar: UIImage{
        if let avatar = model.owner.avatar{
            return UIImage.init(data: avatar)!
        }
        else{
            return UIImage.init(named: "avatar")!
        }
    }
    
    init(model: RepositoryModel) {
        self.model = model
        avatalCancellable = model.owner
            .objectWillChange
            .sink{ [self]_ in
                DispatchQueue.main.async { [weak self] in
                    if self != nil{
                        delegate?.ownerHasChanged()
                    }
                }
            }
        commitsCancellable = model.$commits
            .sink(receiveValue: { [weak self] _ in
                DispatchQueue.main.async { [weak self] in
                    self!.loadCommitAvatar()
                }
            })
    }
    
    func initialise(){
        loadAvatar()
        loadDetailInfo()
        loadCommits()
    }
    
    func loadAvatar(){
        if !model.owner.avatarLoaded{
            model.owner.loadAvatar(avatarStringURL: model.owner.json.avatarURL)
        }
    }
    
    func loadDetailInfo(){
        if !model.detailInfoLoaded{
            model.loadDetailInfo()
        }
    }
    
    func loadCommits(){
        if !model.commitsLoaded{
            model.loadCommits()
        }
    }
    
    func loadCommitAvatar(){
        if model.commits != nil{
            for commit in model.commits! {
                if !commit.avatarLoaded{
                    commit.loadAvatar()
                }
            }
        }
        else{
            model.loadCommits()
        }
    }
    
    func saveToFavorites(){
        provider.saveToFavorites(repositoryModel: model)
    }
    
    func containsInFavorites() -> Bool{
        return provider.containsInFavorites(repositoryModel: model)
    }
    
    func deleteFromFavorites(){
        provider.deleteFromFavorites(repositoryID: model.json.id!)
    }
}
