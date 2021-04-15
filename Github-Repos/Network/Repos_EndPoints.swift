//
//  Repos_EndPoints.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation

protocol EndPoint {
    var path: String { get }
    var method: NetworkRequestMethod { get }
    var headers: [String : Any] { get }
    var parameters: [String: Any] { get }
}




