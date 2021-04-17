//
//  UIImageViewExtTests.swift
//  Github-ReposTests
//
//  Created by sHiKoOo on 4/17/21.
//

import XCTest
@testable import Github_Repos

class UIImageViewExtTests: XCTestCase {

    var sut: UIImageView?

    override func setUpWithError() throws {
        sut = UIImageView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
        
    func testDownloadAndCasheImageFromURL_Performance() {
        measure {
            sut?.downloadFrom(fromLink: "https://avatars.githubusercontent.com/u/1?v=4", contentMode: .scaleAspectFill)
        }
    }

}
