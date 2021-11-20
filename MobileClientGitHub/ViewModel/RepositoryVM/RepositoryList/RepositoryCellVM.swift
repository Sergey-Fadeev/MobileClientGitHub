//
//  RepositoryCellVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 13.11.2021.
//

import Foundation
import UIKit
import Combine


class RepositoryCellVM {
    
    let provider = Provider()
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
//            return UIImage.init(named: "github")!
            return UIImage.init(named: "avatar")!
        }
    }
    
    
    weak var UI: RepositoryViewCell!
    
    
    private var avatalCancellable: Cancellable? = nil
    private var commitsCancellable: Cancellable? = nil
    
    private var detailInfoCancellable: Cancellable? = nil
    
    
    init(model: RepositoryModel) {
        self.model = model
        
        avatalCancellable = model.owner
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
//                    self?.UI.tableView.delegate = self?.UI
//                    self?.UI.tableView.register(UINib(nibName: "CommitTableViewCell", bundle: nil), forCellReuseIdentifier: "commitCustomCell")
//                    self?.UI.tableView.dataSource = self?.UI
                    
                    self!.loadCommitAvatar()
                }
            })
    }
    
    
    func updateUI(){
        loadAvatar()
        loadDetailInfo()
        loadCommits()
        loadCommitAvatar()
        
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
        
        UI.ownersImageView.layer.cornerRadius = UI.ownersImageView.frame.size.width / 2 - 10
        UI.ownersImageView.clipsToBounds = true
        
        UI.languageName.text = "  " + language
        UI.starLabel.text = "  " + starCount
        UI.forkLabel.text = " " + forkCount
        
        if !containsInFavorites(){
            UI.saveButtonOutlet.tintColor = UIColor.systemGreen
            UI.saveButtonOutlet.setTitle("Add", for: .normal)
        }
        else{
            UI.saveButtonOutlet.tintColor = UIColor.gray
            UI.saveButtonOutlet.setTitle("Added", for: .normal)
        }
        
        UI.reloadInputViews()
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
    
    
    
//    func loadCommitAvatar(){
//        if !model.owner.avatarLoaded{
//            model.owner.loadAvatar(avatarStringURL: model.owner.json.avatarURL)
//        }
//    }
    
    func loadCommitAvatar(){
//        model.loadCommits()   //под вопросом
        if model.commits != nil{
            for commit in model.commits! {
                commit.loadAvatar()
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
        provider.deleteFromFavorites(repositoryModel: model)
    }
}
