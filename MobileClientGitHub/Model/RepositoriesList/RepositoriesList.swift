//
//  RepositoriesList.swift
//  MobileClientGitHub
//
//  Created by Sergey on 27.10.2021.
//

import Foundation

class RepositoriesList {
    var repositoryList: [ElementJSON]?
    
    init?(dataRepo: FullJSON) {
        self.repositoryList = dataRepo
    }
}
