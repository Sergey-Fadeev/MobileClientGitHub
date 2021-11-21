//
//  RepositoryDetailVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 14.11.2021.
//


import Foundation
import UIKit
import Combine


class RepositoryDetailVM {
    
    let model: RepositoryModel
    
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
    
    
    weak var UI: RepositoryDetailVC!
    
    
    private var avatarCancellable: Cancellable? = nil
    
    
    private var detailInfoCancellable: Cancellable? = nil
    
    
    private var commitsCancellable: Cancellable? = nil
    
    
    init(model: RepositoryModel) {
        self.model = model
        
        avatarCancellable = model.owner
            .objectWillChange
            .sink{ [self]_ in
                DispatchQueue.main.async { [weak self] in
                    if self != nil{
                        self!.UI.ownersImageView.image = avatar
                    }
                }
            }
        
        detailInfoCancellable = model.owner
            .objectWillChange
            .sink{ [self]_ in
                DispatchQueue.main.async { [weak self] in
                    if self != nil{
                        self?.UI.languageName.text = self?.language
                        self?.UI.starLabel.text = self?.starCount
                        self?.UI.forkLabel.text = self?.forkCount
                    }
                }
            }
        
        commitsCancellable = model.$commits
            .sink(receiveValue: { [weak self] _ in
                DispatchQueue.main.async { [weak self] in
                    
                    self?.UI.tableView.reloadData()
                }
            })
    }
    
    
    func updateUI(){
        loadAvatar()
        loadDetailInfo()
        
        switch language {
        case "JavaScript":
            UI.languageImage.image = UIImage.init(named: "javaScript")
        case "Ruby":
            UI.languageImage.image = UIImage.init(named: "ruby")
        default:
            UI.languageImage.image = UIImage.init(named: "empty")
        }
        
        UI.authorsFullName.text = login
        UI.projectNameLabel.text = title
        UI.descriptionLabel.text = description
        UI.ownersImageView.image = avatar
        
        UI.ownersImageView.layer.cornerRadius = UI.ownersImageView.frame.size.width / 2
        UI.ownersImageView.clipsToBounds = true
        
        UI.languageName.text = "  " + language
        UI.starLabel.text = "  " + starCount
        UI.forkLabel.text = " " + forkCount
        
        loadCommits()
        UI.tableView.reloadData()
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
