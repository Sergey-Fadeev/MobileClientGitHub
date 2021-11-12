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
    
    
    
    
    func fetchAvatar(imageURLString: String?) -> AnyPublisher<Data?, Never> {
        guard let imageURLString = imageURLString else {
            return Just(nil)
                .eraseToAnyPublisher()
        }
        let url = URL.init(string: imageURLString)
        
        guard let url = url else {
            return Just(nil)
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .catch { error in Just(nil)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    
    func fetchDetailInfo(fullName: String) -> AnyPublisher<DetailInfo, Never>{
        
        
        guard let url = absoluteURL(fullName: fullName) else {
            return Just(DetailInfo.init(id: nil, nodeID: nil, name: nil, fullName: nil, welcomePrivate: nil, owner: nil, htmlURL: nil, welcomeDescription: nil, fork: nil, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL: nil, stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil, createdAt: nil, updatedAt: nil, pushedAt: nil, gitURL: nil, sshURL: nil, cloneURL: nil, svnURL: nil, homepage: nil, size: nil, stargazersCount: nil, watchersCount: nil, language: nil, hasIssues: nil, hasProjects: nil, hasDownloads: nil, hasWiki: nil, hasPages: nil, forksCount: nil, mirrorURL: nil, archived: nil, disabled: nil, openIssuesCount: nil, license: nil, allowForking: nil, isTemplate: nil, topics: nil, visibility: nil, forks: nil, openIssues: nil, watchers: nil, defaultBranch: nil, tempCloneToken: nil, networkCount: nil, subscribersCount: nil))
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .decode(type: DetailInfo.self, decoder: JSONDecoder())
            .catch { error in Just(DetailInfo.init(id: nil, nodeID: nil, name: nil, fullName: nil, welcomePrivate: nil, owner: nil, htmlURL: nil, welcomeDescription: nil, fork: nil, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL: nil, stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil, createdAt: nil, updatedAt: nil, pushedAt: nil, gitURL: nil, sshURL: nil, cloneURL: nil, svnURL: nil, homepage: nil, size: nil, stargazersCount: nil, watchersCount: nil, language: nil, hasIssues: nil, hasProjects: nil, hasDownloads: nil, hasWiki: nil, hasPages: nil, forksCount: nil, mirrorURL: nil, archived: nil, disabled: nil, openIssuesCount: nil, license: nil, allowForking: nil, isTemplate: nil, topics: nil, visibility: nil, forks: nil, openIssues: nil, watchers: nil, defaultBranch: nil, tempCloneToken: nil, networkCount: nil, subscribersCount: nil))}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
