//
//  JSON.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import Foundation


// MARK: - WelcomeElement
struct ElementJSON: Codable {
    let id: Int?
    let nodeID, name, fullName: String?
    let welcomePrivate: Bool?
    let owner: OwnerJSON?
    let htmlURL: String?
    let description: String?
    let fork: Bool?
    let url, forksURL: String?
    let keysURL, collaboratorsURL: String?
    let teamsURL, hooksURL: String?
    let issueEventsURL: String?
    let eventsURL: String?
    let assigneesURL, branchesURL: String?
    let tagsURL: String?
    let blobsURL, gitTagsURL, gitRefsURL, treesURL: String?
    let statusesURL: String?
    let languagesURL, stargazersURL, contributorsURL, subscribersURL: String?
    let subscriptionURL: String?
    let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String?
    let contentsURL, compareURL: String?
    let mergesURL: String?
    let archiveURL: String?
    let downloadsURL: String?
    let issuesURL, pullsURL, milestonesURL, notificationsURL: String?
    let labelsURL, releasesURL: String?
    let deploymentsURL: String?
    
    static var placeholder: Self{
        return ElementJSON(id: nil, nodeID: nil, name: nil, fullName: nil, welcomePrivate: nil, owner: nil, htmlURL: nil, description: nil, fork: nil, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL: nil, stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case welcomePrivate = "private"
        case owner
        case htmlURL = "html_url"
        case description = "description"
        case fork, url
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
    }
}

// MARK: - Owner
struct OwnerJSON: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: TypeEnumCommitsJSON
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

enum TypeEnumCommitsJSON: String, Codable {
    case organization = "Organization"
    case user = "User"
}


typealias FullJSON = [ElementJSON]?



// MARK: - DetailInfoJSON

struct DetailJSON: Codable {
    let id: Int?
    let nodeID, name, fullName: String?
    let welcomePrivate: Bool?
    let owner: OwnerDetailJSON?
    let htmlURL: String?
    let welcomeDescription: String?
    let fork: Bool?
    let url, forksURL: String?
    let keysURL, collaboratorsURL: String?
    let teamsURL, hooksURL: String?
    let issueEventsURL: String?
    let eventsURL: String?
    let assigneesURL, branchesURL: String?
    let tagsURL: String?
    let blobsURL, gitTagsURL, gitRefsURL, treesURL: String?
    let statusesURL: String?
    let languagesURL, stargazersURL, contributorsURL, subscribersURL: String?
    let subscriptionURL: String?
    let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String?
    let contentsURL, compareURL: String?
    let mergesURL: String?
    let archiveURL: String?
    let downloadsURL: String?
    let issuesURL, pullsURL, milestonesURL, notificationsURL: String?
    let labelsURL, releasesURL: String?
    let deploymentsURL: String?
    let createdAt, updatedAt, pushedAt: Date?
    let gitURL, sshURL: String?
    let cloneURL: String?
    let svnURL: String?
    let homepage: String?
    let size, stargazersCount, watchersCount: Int?
    let language: String?
    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool?
    let hasPages: Bool?
    let forksCount: Int?
    let archived, disabled: Bool?
    let openIssuesCount: Int?
    let license: License?
    let allowForking, isTemplate: Bool?
    let visibility: String?
    let forks, openIssues, watchers: Int?
    let defaultBranch: String?
    let networkCount, subscribersCount: Int?
    
    static var placeholder: Self{
        return DetailJSON(id: nil, nodeID: nil, name: nil, fullName: nil, welcomePrivate: nil, owner: nil, htmlURL: nil, welcomeDescription: nil, fork: nil, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL: nil, stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil, createdAt: nil, updatedAt: nil, pushedAt: nil, gitURL: nil, sshURL: nil, cloneURL: nil, svnURL: nil, homepage: nil, size: nil, stargazersCount: nil, watchersCount: nil, language: nil, hasIssues: nil, hasProjects: nil, hasDownloads: nil, hasWiki: nil, hasPages: nil, forksCount: nil, archived: nil, disabled: nil, openIssuesCount: nil, license: nil, allowForking: nil, isTemplate: nil, visibility: nil, forks: nil, openIssues: nil, watchers: nil, defaultBranch: nil, networkCount: nil, subscribersCount: nil)
    }
}


struct License: Codable {
    let key, name, spdxID: String
    let url: String
    let nodeID: String
}


struct OwnerDetailJSON: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool
}



//// MARK: - WelcomeElement
//struct WelcomeElement: Codable {
//    let sha, nodeID: String
//    let commit: Commit
//    let url, htmlURL, commentsURL: String
//    let author, committer: WelcomeAuthor
//    let parents: [Parent]
//
//    enum CodingKeys: String, CodingKey {
//        case sha
//        case nodeID = "node_id"
//        case commit, url
//        case htmlURL = "html_url"
//        case commentsURL = "comments_url"
//        case author, committer, parents
//    }
//}
//
//// MARK: - WelcomeAuthor
//struct WelcomeAuthor: Codable {
//    let login: String
//    let id: Int
//    let nodeID: String
//    let avatarURL: String
//    let gravatarID: String
//    let url, htmlURL, followersURL: String
//    let followingURL, gistsURL, starredURL: String
//    let subscriptionsURL, organizationsURL, reposURL: String
//    let eventsURL: String
//    let receivedEventsURL: String
//    let siteAdmin: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case login, id
//        case nodeID = "node_id"
//        case avatarURL = "avatar_url"
//        case gravatarID = "gravatar_id"
//        case url
//        case htmlURL = "html_url"
//        case followersURL = "followers_url"
//        case followingURL = "following_url"
//        case gistsURL = "gists_url"
//        case starredURL = "starred_url"
//        case subscriptionsURL = "subscriptions_url"
//        case organizationsURL = "organizations_url"
//        case reposURL = "repos_url"
//        case eventsURL = "events_url"
//        case receivedEventsURL = "received_events_url"
//        case type
//        case siteAdmin = "site_admin"
//    }
//}
//
//
//// MARK: - Commit
//struct Commit: Codable {
//    let author, committer: CommitAuthor
//    let message: String
//    let tree: Tree
//    let url: String
//    let commentCount: Int
//    let verification: Verification
//
//    enum CodingKeys: String, CodingKey {
//        case author, committer, message, tree, url
//        case commentCount = "comment_count"
//        case verification
//    }
//}
//
//// MARK: - CommitAuthor
//struct CommitAuthor: Codable {
//    let name, email: String
//    let date: Date
//}
//
//// MARK: - Tree
//struct Tree: Codable {
//    let sha: String
//    let url: String
//}
//
//// MARK: - Verification
//struct Verification: Codable {
//    let verified: Bool
//    let reason: Reason
//    let signature, payload: JSONNull?
//}
//
//enum Reason: String, Codable {
//    case unsigned = "unsigned"
//}
//
//// MARK: - Parent
//struct Parent: Codable {
//    let sha: String
//    let url, htmlURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case sha, url
//        case htmlURL = "html_url"
//    }
//}
//
//typealias Welcome = [WelcomeElement]



//https://api.github.com/repos/mojombo/grit/commits

