//
//  RepoViewModel.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation


class RepoViewModel {
    
    public private (set) var reposData: [ReposData]?
    var delegate: NetworkHandler? // delegate to pass actions
    
}


// MARK: NETWORKING
extension RepoViewModel {
    // Get all repos data
    func getAllRepos() {
        NetworkServices.request(endPoint: Repos_EndPoints.listGithubRepos, responseClass: [ReposData].self) { (reData, error) in
            if let repos = reData {
                self.reposData = repos
                self.delegate?.successNetworkRequest()
            }else {
                switch error {
                case .connectionError(let msg):
                    self.delegate?.failedNetworkRequest(withError: msg)
                case .serverError(let msg):
                    self.delegate?.failedNetworkRequest(withError: msg)
                case .responseError(let msg):
                    self.delegate?.failedNetworkRequest(withError: msg)
                default:
                    self.delegate?.failedNetworkRequest(withError: "UNKNOWN")
                }
            }
        }
    }
    
    // Search repos for the query entered
    func searchForRepos(query: String) {
        NetworkServices.request(endPoint: Repos_EndPoints.searchGithubRepos(q: query), responseClass: SearchModelData.self) { (reData, error) in
            if let repos = reData {
                self.reposData = repos.items
                self.delegate?.successNetworkRequest()
            }else {
                switch error {
                case .connectionError(let msg):
                    self.delegate?.failedNetworkRequest(withError: msg)
                case .serverError(let msg):
                    self.delegate?.failedNetworkRequest(withError: msg)
                case .responseError(let msg):
                    self.delegate?.failedNetworkRequest(withError: msg)
                default:
                    self.delegate?.failedNetworkRequest(withError: "UNKNOWN")
                }
            }
        }
    }
}
