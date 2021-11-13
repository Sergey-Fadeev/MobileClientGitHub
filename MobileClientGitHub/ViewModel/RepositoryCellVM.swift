//
//  RepositoryCellVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 13.11.2021.
//

import Foundation


class RepositoryCellVM {
    
    let model: RepositoryModel
    
    init(model: RepositoryModel) {
        self.model = model
    }
    
    func addAvatar(avatarStringURL: String){
        model.owner.loadAvatar(avatarStringURL: avatarStringURL)
    }
    
    func addDetailInfo(fullNameRepository: String){
        model.owner.loadDetailInfo(fullNameRepository: fullNameRepository)
    }
}
