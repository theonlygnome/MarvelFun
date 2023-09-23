//
//  Series.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/23/23.
//

import Foundation

struct SeriesResults: Codable {
    let data: SeriesDataContainer
}

struct SeriesDataContainer: Codable {
    let count: Int
    let total: Int
    let results: [Series]
}

struct Series: Codable, Hashable {
    static func == (lhs: Series, rhs: Series) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let thumbnail: SeriesImage
}

struct SeriesImage: Codable, Hashable {
    let path: String
    let `extension`: String
}
