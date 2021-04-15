//
//  EndPoint.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation

enum Repos_EndPoints: EndPoint {
    // Repo
    case listGithubRepos
    case getDate(dateURL: String)
    case searchGithubRepos(q: String)
    
    var path: String {
        switch self {
        case .listGithubRepos:
            return "https://api.github.com/repositories"
        case .getDate(let dateURL):
            return dateURL
        case .searchGithubRepos(let query):
            return "https://api.github.com/search/repositories?q=\(query)&sort=stars&order=desc"
        }
    }
    
    var method: NetworkRequestMethod {
        switch self {
        case .listGithubRepos, .getDate, .searchGithubRepos:
            return .get
        }
    }
    
    var headers: [String : Any] {
        switch self {
        case .listGithubRepos, .getDate, .searchGithubRepos:
            return [:]
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .listGithubRepos, .getDate:
            return [:]
        case .searchGithubRepos(let q):
            return ["q":q]
        }
    }
    
}
