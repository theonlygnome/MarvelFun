//
//  CharacterTests.swift
//  MarvelFunTests
//
//  Created by Naomi Anderson on 9/23/23.
//

import XCTest

let testCharacter_Superman: Data = """
    {
        "id":1011334,
        "name":"Superman",
        "description":"Superman can fly.",
        "modified":"2014-04-29T14:18:17-0400",
        "thumbnail":
            {
            "path":"http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
            "extension":"jpg"
            }
    }
    """.data(using: .utf8)!

class CharacterTests: XCTestCase {
    func testJSONDecoderDecodesCharacter() throws {
        let decoder = JSONDecoder()
        let character = try decoder.decode(Character.self, from: testCharacter_Superman)

        XCTAssertEqual(character.name, "Superman")
    }

}
