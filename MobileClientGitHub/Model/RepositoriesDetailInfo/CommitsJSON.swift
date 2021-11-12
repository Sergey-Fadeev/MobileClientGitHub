// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

//import Foundation
//
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
