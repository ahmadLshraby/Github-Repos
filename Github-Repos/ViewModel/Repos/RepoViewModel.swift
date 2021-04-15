//
//  RepoViewModel.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation


class RepoViewModel {
    
    public private (set) var reposData: [ReposData]?
    
}


// MARK: NETWORKING
extension RepoViewModel {
    // Get all repos data
    func getAllRepos(handler: @escaping(Bool, String) -> Void) {
        NetworkServices.request(endPoint: Repos_EndPoints.listGithubRepos, responseClass: [ReposData].self) { (reData, error) in
            if let repos = reData {
                self.reposData = repos
                handler(true, "")
            }else {
                switch error {
                case .connectionError(let msg):
                    handler(false, msg)
                case .serverError(let msg):
                    handler(false, msg)
                case .responseError(let msg):
                    handler(false, msg)
                default:
                    handler(false, "UNKOWN")
                }
            }
        }
    }
    
    // Search repos for the query entered
    func searchForRepos(query: String, handler: @escaping(Bool, String) -> Void) {
        NetworkServices.request(endPoint: Repos_EndPoints.searchGithubRepos(q: query), responseClass: SearchModelData.self) { (reData, error) in
            if let repos = reData {
                self.reposData = repos.items
                handler(true, "")
            }else {
                switch error {
                case .connectionError(let msg):
                    handler(false, msg)
                case .serverError(let msg):
                    handler(false, msg)
                case .responseError(let msg):
                    handler(false, msg)
                default:
                    handler(false, "UNKOWN")
                }
            }
        }
    }
}
