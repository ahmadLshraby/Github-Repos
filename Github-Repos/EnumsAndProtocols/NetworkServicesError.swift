//
//  NetworkServicesError.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation

enum NetworkServicesError {
    case serverError(serverError: String)
    case connectionError(connection: String)
    case responseError(response: String)
    case authenticationError
}
