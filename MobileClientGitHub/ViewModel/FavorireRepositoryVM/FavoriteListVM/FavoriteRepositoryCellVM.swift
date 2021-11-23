//
//  FavoriteRepositoryCellVM.swift
//  MobileClientGitHub
//
//  Created by Sergey on 23.11.2021.
//

import Foundation


class FavoriteRepositoryCellVM {
    let provider = Provider()
    
    func deleteFromFavorites(repositoryID: Int){
        provider.deleteFromFavorites(repositoryID: repositoryID)
    }
}
