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
    
    init(json: ElementJSON) {
        self.json = json
        self.owner = .init(json: json.owner!)
    }
}


class OwnerModel: ObservableObject{
    
    let json: OwnerJSON
    
    let provider = Provider()
    
    
    var avatarCancellable: Cancellable? = nil
    func loadAvatar(avatarStringURL: String){
        avatarCancellable = provider.fetchAvatar(avatarStringURL: avatarStringURL).sink { imageData in
            self.avatar = imageData
        }
    }
    @Published var avatar: Data?
    
    
    var detailInfoCancellable: Cancellable? = nil
    func loadDetailInfo(fullNameRepository: String){
        detailInfoCancellable = provider.fetchDetailInfo(fullNameRepository: fullNameRepository).sink(receiveValue: { json in
            self.detailInfo = json
        })
    }
    @Published var detailInfo: DetailJSON?
    
    
    init(json: OwnerJSON) {
        self.json = json
    }
}
