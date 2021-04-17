//
//  ReposVCTests.swift
//  Github-ReposTests
//
//  Created by sHiKoOo on 4/17/21.
//

import XCTest
@testable import Github_Repos

class ReposVCTests: XCTestCase {

    // sut = System Under Test
    var sut: ReposVC?
    
    override func setUpWithError() throws {
        // setup and instantiate the object
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "ReposVC") as? ReposVC
        sut?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // clean up the tested object to get a new object every time
        sut = nil
    }
    
    // test, the case, the result
    func testInit_ViewModelAndSearch_AreNotNil() {
        XCTAssertNotNil(sut?.search)
        XCTAssertNotNil(sut?.reposViewModel)
        XCTAssertNotNil(sut?.refreshControl)
    }
    
    func testSearch_WhenGivenString_HoldTheCharactersAndViewModelWillDoSearch() {
        let searchText = sut?.search.searchBar.text ?? ""
        
        if searchText.count == 0 {
            XCTAssertEqual(searchText.count, 0)
            
        }else if searchText.count % 2 == 0 {
            XCTAssertNotEqual(searchText.count, 0)
            XCTAssertNotNil(sut?.reposViewModel.reposData)
            XCTAssertNotEqual(sut?.reposViewModel.reposData?.count, 0)
            
        }
    }

}
