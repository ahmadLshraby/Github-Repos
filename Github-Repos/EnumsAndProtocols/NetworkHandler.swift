//
//  NetworkHandler.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import UIKit

protocol NetworkHandler {
    func successNetworkRequest()
    func failedNetworkRequest(withError error: String)
}
