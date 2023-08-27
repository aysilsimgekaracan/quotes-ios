//
//  QuoteResponse.swift
//  quotes
//
//  Created by Ayşıl Simge Karacan on 27.08.2023.
//

import Foundation

struct QuoteResponse: Codable {
    let success: Bool
    let count: Int
    let data: [Quote]
}
