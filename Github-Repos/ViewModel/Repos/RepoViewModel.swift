//
//  RepoViewModel.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation
import Combine

class RepoViewModel {
    
    var passSubject = PassthroughSubject<[ReposData], NetworkServicesError>()
    
}


// MARK: NETWORKING
extension RepoViewModel {
    // Get all repos data
    func getAllRepos() {
        NetworkServices.request(endPoint: Repos_EndPoints.listGithubRepos, responseClass: [ReposData].self) { (reData, error) in
            if let repos = reData {
                self.passSubject.send(repos)
            }else {
                self.passSubject.send(completion: Subscribers.Completion<NetworkServicesError>.failure(error!))
            }
        }
    }
    
    // Search repos for the query entered
    func searchForRepos(query: String) {
        NetworkServices.request(endPoint: Repos_EndPoints.searchGithubRepos(q: query), responseClass: SearchModelData.self) { (reData, error) in
            if let repos = reData?.items {
                self.passSubject.send(repos)
            }else {
                self.passSubject.send(completion: Subscribers.Completion<NetworkServicesError>.failure(error!))
            }
        }
    }
}
