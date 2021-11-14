//
//  ReactiveModel.swift
//  MobileClientGitHub
//
//  Created by Sergey on 13.11.2021.
//

import Foundation
import Combine


class RepositoryModel: ObservableObject{
    
    let json: ElementJSON
    let owner: OwnerModel
    
    
    var detailInfoCancellable: Cancellable? = nil
    func loadDetailInfo(){
        guard let url = json.fullName else { return }
        
        detailInfoCancellable = modelSingleton.provider.fetchDetailInfo(fullNameRepository: url).sink(receiveValue: {
            json in
            self.detailInfo = json
            self.detailInfoLoaded = true
        })
    }
    
    
    private(set) var detailInfoLoaded = false
    
    
    @Published var detailInfo: DetailJSON?
    
    
    
    private(set) var commitsLoaded = false
    
    
    var commitsCancellable: Cancellable? = nil
    
    
    @Published var commits: [CommitModel]?
    
    
    func loadCommits(){
        guard let url = json.fullName else { return }
        
        commitsCancellable = modelSingleton.provider.fetchCommits(fullNameRepository: url).sink(receiveValue: {
            json in
            self.commits = json.map({ CommitModel.init(json: $0)})
            self.commitsLoaded = true
        })
    }
    
    
    init(json: ElementJSON) {
        self.json = json
        self.owner = .init(json: json.owner!)
    }
}


class OwnerModel: ObservableObject{
    
    let json: OwnerJSON
    
    
    var avatarCancellable: Cancellable? = nil
    func loadAvatar(avatarStringURL: String){
        avatarCancellable = modelSingleton.provider.fetchAvatar(avatarStringURL: avatarStringURL).sink { imageData in
            self.avatar = imageData
            self.avatarLoaded = true
        }
    }
    
    
    private(set) var avatarLoaded = false
    
    
    @Published var avatar: Data?

    
    init(json: OwnerJSON) {
        self.json = json
    }
}


class CommitModel: ObservableObject{
    let json: CommitElement
    
    
    var avatarCancellable: Cancellable? = nil
    func loadAvatar(){
        guard let url = json.author?.avatarURL else { return }
        
        avatarCancellable = modelSingleton.provider.fetchAvatar(avatarStringURL: url).sink { imageData in
            self.avatar = imageData
            self.avatarLoaded = true
        }
    }
    
    
    private(set) var avatarLoaded = false
    
    
    @Published var avatar: Data?
    
    
    init(json: CommitElement) {
        self.json = json
    }
}
