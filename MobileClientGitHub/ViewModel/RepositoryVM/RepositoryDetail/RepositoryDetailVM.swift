//
//  RepositoryDetailVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 14.11.2021.
//


import Foundation
import UIKit
import Combine


protocol RepositoryDetailVM_Delegate: AnyObject{
    func ownerHasChanged()
    func commitsHasChanged()
}

class RepositoryDetailVM {
    
    let model: RepositoryModel
    private var avatarCancellable: Cancellable? = nil
    private var commitsCancellable: Cancellable? = nil
    var delegate: RepositoryDetailVM_Delegate?
    
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
            return UIImage(named: "avatar")!
        }
    }
    
    var commits: [CommitModel]{
        if let commits = model.commits{
            return commits
        }
        else{
            return []
        }
    }
    
    
    init(model: RepositoryModel) {
        self.model = model
        avatarCancellable = model.owner
            .objectWillChange
            .sink{ [self]_ in
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.ownerHasChanged()
                }
            }
        commitsCancellable = model.$commits
            .sink(receiveValue: { [weak self] _ in
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.commitsHasChanged()
                }
            })
    }
    
    func initialize(){
        loadAvatar()
        loadDetailInfo()
        loadCommits()
    }
    
    func cellModel(at indexPath: IndexPath) -> CommitModel? {
        return commits[indexPath.row]
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
}
