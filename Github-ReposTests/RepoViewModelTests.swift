//
//  RepoViewModelTests.swift
//  Github-ReposTests
//
//  Created by sHiKoOo on 4/17/21.
//

import XCTest
@testable import Github_Repos

class RepoViewModelTests: XCTestCase {
    
    // sut = System Under Test
    var sut: RepoViewModel?
    
    override func setUpWithError() throws {
        // setup and instantiate the object
        sut = RepoViewModel()
        sut?.getAllRepos()
    }

    override func tearDownWithError() throws {
        // clean up the tested object to get a new object every time
        sut = nil
        super.tearDown()
    }
    
    // MARK: - NETWORKING
    func testFetchingRepos_GetTheReturnedData() {
        guard let url = URL(string: Repos_EndPoints.listGithubRepos.path) else { XCTFail(); return }
        let sessionExpectation = expectation(description: "Session")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            } else {
                do {
                    if let data = data  {
                        let responseObj = try JSONDecoder().decode([ReposData].self, from: data)
                        sessionExpectation.fulfill()
                        XCTAssertNotNil(responseObj.first?.htmlURL)
                        XCTAssertEqual(self.sut?.reposData?.first?.name, responseObj.first?.name)
                        XCTAssertEqual(self.sut?.reposData?.last?.owner?.login, responseObj.last?.owner?.login)
                    }else {
                        XCTFail("Data Error")
                    }
                }catch {
                    XCTFail(error.localizedDescription)
                }
            }
        }.resume()
        waitForExpectations(timeout: 8, handler: nil)
    }
    
    func testSearchingRepos_GetTheReturnedData() {
        guard let url = URL(string: Repos_EndPoints.searchGithubRepos(q: "Swift").path) else { XCTFail(); return }
        let sessionExpectation = expectation(description: "Session")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            } else {
                do {
                    if let data = data  {
                        let responseObj = try JSONDecoder().decode(SearchModelData.self, from: data)
                        sessionExpectation.fulfill()
                        XCTAssertNotNil(responseObj.items)
                        XCTAssertEqual(self.sut?.reposData?.first?.name, responseObj.items?.first?.name)
                        XCTAssertEqual(self.sut?.reposData?.last?.owner?.login, responseObj.items?.last?.owner?.login)
                    }else {
                        XCTFail("Data Error")
                    }
                }catch {
                    XCTFail(error.localizedDescription)
                }
            }
        }.resume()
        waitForExpectations(timeout: 8, handler: nil)
    }
    
    // MARK: - PERFORMANCE
    func testGetRepos_Performance() {
        measure {
            sut?.getAllRepos()
        }
    }
    
    func testSearchRepos_Performance() {
        measure {
            sut?.searchForRepos(query: "Swift")
        }
    }

}
