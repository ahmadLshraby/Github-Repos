//
//  ReposVC.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import UIKit
import SafariServices
import Combine

class ReposVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    
    var search = UISearchController(searchResultsController: nil)
    let reposViewModel = RepoViewModel()
    var reposData = [ReposData]()
    var refreshControl = UIRefreshControl()
    var observer: NSKeyValueObservation?
    var cancellable: [AnyCancellable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        addRefreshControllerToTable()
        changeNavigationBarTitleView(KVO: &observer, largeTitle: "GitHub-Repos", smallImageName: "github")
        bindTableViewData()
        getRepos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationSearch()
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func addRefreshControllerToTable() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.darkGray])
        refreshControl.tintColor = .label
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    // Navigation Bar UI customization
    fileprivate func setupNavigationSearch() {
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Search Repo"
        search.searchBar.barTintColor = .label
        search.searchBar.tintColor = .label
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        search.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = search
    }
    
    @IBAction func searchBtnTapped(_ sender: UIBarButtonItem) {
        search.isActive = true
        search.searchBar.becomeFirstResponder()
        search.searchBar.setShowsCancelButton(true, animated: true)
    }
    
}


// MARK: VIEW MODEL BINDINGS & ACTIONS
extension ReposVC {
    
    func bindTableViewData() {
        reposViewModel.passSubject
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                self.shouldPresentLoadingView(false)
                self.refreshControl.endRefreshing()
                switch completion {
                case .finished:
                    print("FINISHED")
                case .failure(let error):
                    self.shouldPresentAlertView(true, title: "GitHub-Repos", alertText: error.localizedDescription, actionTitle: "Ok", errorView: nil)
                }
            } receiveValue: { (value) in
                self.shouldPresentLoadingView(false)
                self.refreshControl.endRefreshing()
                self.reposData = value
                self.tableView.reloadData()
            }.store(in: &cancellable)
    }
    
    // pull to refresh data
    @objc func refresh(_ sender: AnyObject) {
        reposViewModel.getAllRepos()
    }
    
    func getRepos() {
        self.shouldPresentLoadingView(true)
        reposViewModel.getAllRepos()
    }
    
    func searchFor(repo q: String) {
        self.shouldPresentLoadingView(true)
        reposViewModel.searchForRepos(query: q)
    }
    
}


// MARK: - TABLEVIEW
extension ReposVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell",for: indexPath) as? RepoCell {
            let repo = reposData[indexPath.row]
            cell.repo = RepoCellViewModel(repo: repo)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = reposData[indexPath.row]
        if let url = URL(string: repo.htmlURL ?? "") {
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }

}
    
    

// MARK: - SEARCH BAR
extension ReposVC: UISearchBarDelegate {
    // auto search after 2 characters
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
    
    // reload all repos when cancel search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
        getRepos()
    }
    
}


// MARK: - SCROLL
extension ReposVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        search.isActive = false
        search.searchBar.resignFirstResponder()
        search.searchBar.setShowsCancelButton(false, animated: true)
    }

}
