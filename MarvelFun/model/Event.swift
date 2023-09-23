//
//  Series.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/23/23.
//

import Foundation

struct EventResults: Codable {
    let data: EventDataContainer
}

struct EventDataContainer: Codable {
    let count: Int
    let total: Int
    let results: [Event]
}

struct Event: Codable, Hashable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let thumbnail: EventImage
}

struct EventImage: Codable, Hashable {
    let path: String
    let `extension`: String
}
