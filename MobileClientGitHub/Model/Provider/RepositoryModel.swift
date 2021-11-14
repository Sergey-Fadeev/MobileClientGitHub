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
    //модель коммитов
    
    var detailInfoCancellable: Cancellable? = nil
    func loadDetailInfo(fullNameRepository: String){
        detailInfoCancellable = modelSingleton.provider.fetchDetailInfo(fullNameRepository: fullNameRepository).sink(receiveValue: {
            json in
            self.detailInfo = json
            self.detailInfoLoaded = true
        })
    }
    
    
    private(set) var detailInfoLoaded = false
    
    
    @Published var detailInfo: DetailJSON?
    
    
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
