//
//  RepoModelData.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation


struct ReposData: Codable {
    let name, fullName: String?
    let owner: Owner?
    let htmlURL: String?
    let repoURL: String?

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
        case repoURL = "url"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

// MARK: Search
struct SearchModelData: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [ReposData]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - ReposDetailsData
struct ReposDetailsData: Codable {
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
    }
}

