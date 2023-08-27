//
//  Quote.swift
//  quotes
//
//  Created by Ayşıl Simge Karacan on 27.08.2023.
//

import Foundation

struct Quote: Codable {
    let id: String
    let name: String
    let author: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case author
        case createdAt
    }
    
}
