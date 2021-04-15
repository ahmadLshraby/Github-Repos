//
//  RepoModelData.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation


struct ReposData: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [RepoModelData]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    //    var imageUrl: String?
    //    var name: String?
    //    var description: String?
    //    var numberOfForks: Int?
    //    var language: String?
    //    var numberOfContributors: Int?
    //    var repoUrl: String?
}

struct RepoModelData: Codable {
    let name, fullName: String?
    let htmlURL: String?
    let itemDescription: String?
    let url: String?
    let language: String?
    let forksCount: Int?
    let contributorsURL: String?
    let forks: Int?
    let owner: Owner?
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case htmlURL = "html_url"
        case itemDescription = "description"
        case url
        case language
        case forksCount = "forks_count"
        case contributorsURL = "contributors_url"
        case forks
        case owner
    }
}

struct Owner: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
