//
//  GitHubAPITests.swift
//  MobileClientGitHubTests
//
//  Created by Sergey on 28.10.2021.
//

import XCTest
import Combine
import UIKit
import Foundation


@testable import MobileClientGitHub

class GitHubAPITests: XCTestCase {

    private let absoluteURL = URL(string: "https://api.github.com/repositories")
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    func test_repositories() {
        
        let baseURL = URL(string: "https://api.github.com/repos/mojombo/grit")!
               
        let (data, urlResponse, error) = URLSession.shared.synchronousDataTask(with: baseURL)
        
        let json_str = String.init(data: data!, encoding: .utf8)
        
        let repoJson = try! JSONDecoder().decode(DetailJSON.self, from: data!)
        print(repoJson)
        
    }
}

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }
        dataTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        return (data, response, error)
    }
}
