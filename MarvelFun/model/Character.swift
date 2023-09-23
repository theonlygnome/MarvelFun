//
//  CharacterData.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/22/23.
//

import Foundation

struct Results: Codable {
    let data: CharacterDataContainer
}

struct CharacterDataContainer: Codable {
    let count: Int
    let total: Int
    let results: [Character]
}

struct Character: Codable, Identifiable, Hashable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable, Hashable {
    let path: String
    let `extension`: String
}

// struct Comics

// struct series
