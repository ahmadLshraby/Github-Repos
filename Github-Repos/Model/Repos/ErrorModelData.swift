//
//  ErrorModelData.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation

struct ErrorModelData: Codable {
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
