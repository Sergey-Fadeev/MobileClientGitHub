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
    @Published var detailInfo: DetailJSON?
    var commitsCancellable: Cancellable? = nil
    @Published var commits: [CommitModel]?
    
    private(set) var detailInfoLoaded = false
    private(set) var commitsLoaded = false
    
    init(json: ElementJSON) {
        self.json = json
        self.owner = .init(json: json.owner!)
    }
    
    func loadDetailInfo(){
        guard let url = json.fullName else { return }
        detailInfoCancellable = modelSingleton.provider.fetchDetailInfo(fullNameRepository: url).sink(receiveValue: {
            json in
            self.detailInfo = json
            self.detailInfoLoaded = true
        })
    }
    
    func loadCommits(){
        guard let url = json.fullName else { return }
        commitsCancellable = modelSingleton.provider.fetchCommits(fullNameRepository: url).sink(receiveValue: {
            json in
            self.commits = json.map({ CommitModel.init(json: $0)})
            self.commitsLoaded = true
        })
    }
}


class OwnerModel: ObservableObject{
    
    let json: OwnerJSON
    var avatarCancellable: Cancellable? = nil
    private(set) var avatarLoaded = false
    @Published var avatar: Data?
    
    init(json: OwnerJSON) {
        self.json = json
    }
    
    func loadAvatar(avatarStringURL: String){
        avatarCancellable = modelSingleton.provider.fetchAvatar(avatarStringURL: avatarStringURL).sink { imageData in
            self.avatar = imageData
            self.avatarLoaded = true
        }
    }
}


class CommitModel: ObservableObject{
    
    let json: CommitElement
    private(set) var avatarLoaded = false
    @Published var avatar: Data?
    var avatarCancellable: Cancellable? = nil
    
    init(json: CommitElement) {
        self.json = json
    }
    
    func loadAvatar(){
        guard let url = json.author?.avatarURL else { return }
        avatarCancellable = modelSingleton.provider.fetchAvatar(avatarStringURL: url).sink { imageData in
            self.avatar = imageData
            self.avatarLoaded = true
        }
    }
}
