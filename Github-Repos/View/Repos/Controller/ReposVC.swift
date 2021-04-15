//
//  ReposVC.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import UIKit
import SafariServices

class ReposVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var search = UISearchController(searchResultsController: nil)
    let reposViewModel = RepoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        getRepos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationSearch()
    }
    
    fileprivate func setupNavigationSearch() {
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Search Repo"
        search.searchBar.barTintColor = .black
        search.searchBar.tintColor = .black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        search.obscuresBackgroundDuringPresentation = true
        self.navigationItem.searchController = search
    }
    
    func getRepos() {
        shouldPresentLoadingView(true)
        reposViewModel.getAllRepos { (done, errorMsg) in
            DispatchQueue.main.async {
                self.shouldPresentLoadingView(false)
                if done {
                    self.tableView.reloadData()
                }else {
                    self.shouldPresentAlertViewWithAction(withTitle: "ERROR",
                                                          message: errorMsg,
                                                          yesActionTitle: "Try Again!",
                                                          noActionTitle: "Cancel",
                                                          yesActionColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                                          noActionColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
                                                          delegate: nil,
                                                          parentViewController: self) { [weak self] (done) in
                        if done {
                            self?.getRepos()
                        }
                    }
                }
            }
        }
    }
    
    func searchFor(repo q: String) {
        shouldPresentLoadingView(true)
        reposViewModel.searchForRepos(query: q) { (done, errorMsg) in
            DispatchQueue.main.async {
                self.shouldPresentLoadingView(false)
                if done {
                    self.tableView.reloadData()
                }else {
                    self.shouldPresentAlertViewWithAction(withTitle: "ERROR",
                                                          message: errorMsg,
                                                          yesActionTitle: "Try Again!",
                                                          noActionTitle: "Cancel",
                                                          yesActionColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                                          noActionColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
                                                          delegate: nil,
                                                          parentViewController: self) { [weak self] (done) in
                        if done {
                            self?.getRepos()
                        }
                    }
                }
            }
        }
    }
    
    


}


// MARK: - TABLEVIEW
extension ReposVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposViewModel.reposData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell",for: indexPath) as? RepoCell {
            if let repo = reposViewModel.reposData?[indexPath.row] {
                cell.repo = RepoCellViewMode(repo: repo)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = reposViewModel.reposData?[indexPath.row]
        if let url = URL(string: repo?.htmlURL ?? "") {
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }

}
    
    

// MARK: - SEARCH BAR
extension ReposVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            getRepos()
        }else if searchText.count % 2 == 0 {
            searchBarSearchButtonClicked(searchBar)
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text ?? ""
        searchFor(repo: query)
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
        getRepos()
    }
    
    
}
