//
//  RepoViewModel.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation


class RepoViewModel {
    
    var repos: Observable<[ReposData]> = Observable([])
    var errorMsg: Observable<String>?
    
}


// MARK: NETWORKING
extension RepoViewModel {
    // Get all repos data
    func getAllRepos() {
        NetworkServices.request(endPoint: Repos_EndPoints.listGithubRepos, responseClass: [ReposData].self) { (reData, error) in
            if let repos = reData {
                self.repos.value = repos
            }else {
                switch error {
                case .connectionError(let msg):
                    self.errorMsg?.value = msg
                case .serverError(let msg):
                    self.errorMsg?.value = msg
                case .responseError(let msg):
                    self.errorMsg?.value = msg
                default:
                    self.errorMsg?.value = "UNKNOWN"
                }
            }
        }
    }
    
    // Search repos for the query entered
    func searchForRepos(query: String) {
        NetworkServices.request(endPoint: Repos_EndPoints.searchGithubRepos(q: query), responseClass: SearchModelData.self) { (reData, error) in
            if let repos = reData {
                self.repos.value = repos.items
            }else {
                switch error {
                case .connectionError(let msg):
                    self.errorMsg?.value = msg
                case .serverError(let msg):
                    self.errorMsg?.value = msg
                case .responseError(let msg):
                    self.errorMsg?.value = msg
                default:
                    self.errorMsg?.value = "UNKNOWN"
                }
            }
        }
    }
}
