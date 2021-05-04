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
    
    init(repo: ReposData) {
        self.name = "Name: " + (repo.name ?? "")
        self.OwnerName = "Owner: " + (repo.owner?.login ?? "")
        self.repoDate = repo.repoURL ?? ""
        imageUrl = repo.owner?.avatarURL ?? ""
    }
    
    
}
