//
//  Provider.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import Foundation
import UIKit
import Combine

class Provider {
    
    
//    func loadModel() -> RepositoryList {
//        var repositoryList: RepositoryList = nil
//        repositoryList?.append(repositoryJson)
//        return repositoryList
//    }
    
    
    private let absoluteURL = URL(string: "https://api.github.com/repositories")


//    func fetchRepositoriesList() -> RepositoryList {
//        var repositoryList: RepositoryList? = nil
//        let baseURL = URL(string: stringURL)
//        URLSession.shared.dataTask(with: baseURL!) { (data, response, error) in
//            guard let data = data else{return}
//            guard error == nil else{return}
//
//            if let repoJson = try? JSONDecoder().decode(RepositoryList.self, from: data){
//                repositoryList = repoJson
//            }else{
//                repositoryList = nil
//            }
//        }
//        .resume()
//        return repositoryList ?? nil
//    }
    
    
    func fetchRepositories() -> AnyPublisher<FullJSON, Never> {
        guard let url = absoluteURL else {                  // 1
            return Just(FullJSON.none)
                .eraseToAnyPublisher()
        }
        
        print("!!!!!!!отработал fetchRepositories в провайдере")
        return
            URLSession.shared.dataTaskPublisher(for:url)                  // 2
            .map { $0.data }                                          // 3
            .decode(type: FullJSON.self, decoder: JSONDecoder()) // 4
            .catch { error in Just(FullJSON.none)}        // 5
            .receive(on: RunLoop.main)                                // 6
            .eraseToAnyPublisher()                                    // 7
    }
    
}
