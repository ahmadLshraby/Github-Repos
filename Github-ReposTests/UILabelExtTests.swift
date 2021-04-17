//
//  UILabelExtTests.swift
//  Github-ReposTests
//
//  Created by sHiKoOo on 4/17/21.
//

import XCTest
@testable import Github_Repos

class UILabelExtTests: XCTestCase {
    
    var sut: UILabel?

    override func setUpWithError() throws {
        sut = UILabel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetDate_FromGivenURL_ReturnString() {
        guard let url = URL(string: "https://api.github.com/repos/mojombo/grit") else { XCTFail(); return }
        let sessionExpectation = expectation(description: "DateSession")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            } else {
                do {
                    if let data = data  {
                        let responseObj = try JSONDecoder().decode(ReposDetailsData.self, from: data)
                        sessionExpectation.fulfill()
                        if let dateString = responseObj.createdAt {
                            DispatchQueue.main.async {
                                self.sut?.convertDateFrom(date: dateString)
                                XCTAssertEqual(self.sut?.text, "Monday, 29 October 2007")
                            }
                        }else {
                            XCTFail("Data Error")
                        }
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
    
    func testGetDateFromURLAndChangeFormat_Performance() {
        measure {
            sut?.getRepoDateFrom(repoUrl: "https://api.github.com/repos/mojombo/grit")
        }
    }

}
