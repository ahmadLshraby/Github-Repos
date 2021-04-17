//
//  RepoCellViewModel.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation

class RepoCellViewModel {
    var name: String?
    var OwnerName: String?
    var imageUrl: String?
    var repoDate: String?
    var repoUrl: URL?
    
    init(repo: ReposData) {
        self.name = "Name: " + (repo.name ?? "")
        self.OwnerName = "Owner: " + (repo.owner?.login ?? "")
        self.repoDate = repo.repoURL ?? ""
        let reUrl = repo.htmlURL ?? ""
        if let url = URL(string: reUrl) {
            self.repoUrl = url
        }
        imageUrl = repo.owner?.avatarURL ?? ""
    }
    
    
}
