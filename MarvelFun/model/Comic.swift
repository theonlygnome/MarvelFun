//
//  Comic.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/22/23.
//

import Foundation

struct ComicResults: Codable {
    let data: ComicDataContainer
}

struct ComicDataContainer: Codable {
    let count: Int
    let total: Int
    let results: [Comic]
}

struct Comic: Codable, Hashable {
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let thumbnail: ComicImage
}

struct ComicImage: Codable, Hashable {
    let path: String
    let `extension`: String
}
