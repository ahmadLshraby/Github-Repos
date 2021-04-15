//
//  RepoCellViewModel.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation

class RepoCellViewMode {
    var name: String?
    var OwnerName: String?
    var imageUrl: URL?
//    var repoDate: String?
    var repoUrl: URL?
    
    init(repo: ReposData) {
        self.name = repo.name ?? ""
        self.OwnerName = repo.owner?.login ?? ""
//        self.repoDate = repo.language ?? ""
        let reUrl = repo.htmlURL ?? ""
        if let url = URL(string: reUrl) {
            self.repoUrl = url
        }
        let imUrl = repo.owner?.avatarURL ?? ""
        if let url = URL(string: imUrl) {
            self.imageUrl = url
        }
    }
}
