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
    
    private let mainURL = URL(string: "https://api.github.com/repositories")
    
    private let detailInfoURL = "https://api.github.com/repos/"
    
    
    private func absoluteURL(fullName: String) -> URL? {
        let queryURL = URL(string: detailInfoURL + fullName)!
        
        return queryURL
    }
    
    
    func fetchRepositories() -> AnyPublisher<FullJSON, Never> {
        guard let url = mainURL else {
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
    
    
    func fetchAvatar(avatarStringURL: String?) -> AnyPublisher<Data, Never> {
        guard avatarStringURL != nil, let url = URL.init(string: avatarStringURL!) else {
            return Just(Data())
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .catch { error in Just(Data())}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func fetchDetailInfo(fullNameRepository: String?) -> AnyPublisher<DetailJSON, Never> {
        
        let baseURL: String = "https://api.github.com/repos/"
        
        guard fullNameRepository != nil, let url = URL.init(string: baseURL + fullNameRepository!) else {
            return Just(DetailJSON.placeholder)
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .decode(type: DetailJSON.self, decoder: JSONDecoder())
            .catch { error in Just(DetailJSON.placeholder)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
//    func fetchDetailInfo(fullName: String) -> AnyPublisher<DetailJSON, Never>{
//
//
//        guard let url = absoluteURL(fullName: fullName) else {
//            return Just(DetailJSON.init(id: nil, nodeID: nil, name: nil, fullName: nil, welcomePrivate: nil, owner: nil, htmlURL: nil, welcomeDescription: nil, fork: nil, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL: nil, stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil, createdAt: nil, updatedAt: nil, pushedAt: nil, gitURL: nil, sshURL: nil, cloneURL: nil, svnURL: nil, homepage: nil, size: nil, stargazersCount: nil, watchersCount: nil, language: nil, hasIssues: nil, hasProjects: nil, hasDownloads: nil, hasWiki: nil, hasPages: nil, forksCount: nil, archived: nil, disabled: nil, openIssuesCount: nil, license: nil, allowForking: nil, isTemplate: nil, visibility: nil, forks: nil, openIssues: nil, watchers: nil, defaultBranch: nil, networkCount: nil, subscribersCount: nil))
//                .eraseToAnyPublisher()
//        }
//        return
//            URLSession.shared.dataTaskPublisher(for:url)
//            .map { $0.data }
//            .decode(type: DetailJSON.self, decoder: JSONDecoder())
//            .catch { error in Just(DetailJSON.init(id: nil, nodeID: nil, name: nil, fullName: nil, welcomePrivate: nil, owner: nil, htmlURL: nil, welcomeDescription: nil, fork: nil, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL: nil, stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil, createdAt: nil, updatedAt: nil, pushedAt: nil, gitURL: nil, sshURL: nil, cloneURL: nil, svnURL: nil, homepage: nil, size: nil, stargazersCount: nil, watchersCount: nil, language: nil, hasIssues: nil, hasProjects: nil, hasDownloads: nil, hasWiki: nil, hasPages: nil, forksCount: nil, archived: nil, disabled: nil, openIssuesCount: nil, license: nil, allowForking: nil, isTemplate: nil, visibility: nil, forks: nil, openIssues: nil, watchers: nil, defaultBranch: nil, networkCount: nil, subscribersCount: nil))}
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
//    }
}
