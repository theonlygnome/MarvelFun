//
//  String.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/22/23.
//  Sourced from https://powermanuscript.medium.com/swift-5-2-macos-md5-hash-for-some-simple-use-cases-66be9e274182
//

import Foundation
import CryptoKit

// THIS IS NOT WORKING YET
extension String {
    var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
