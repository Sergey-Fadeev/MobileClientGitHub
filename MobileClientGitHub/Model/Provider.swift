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
    
    private let absoluteURL = URL(string: "https://api.github.com/repositories")
    
    
    func fetchRepositories() -> AnyPublisher<FullJSON, Never> {
        guard let url = absoluteURL else {
            return Just(FullJSON.none)
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .decode(type: FullJSON.self, decoder: JSONDecoder())
            .catch { error in Just(FullJSON.none)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
