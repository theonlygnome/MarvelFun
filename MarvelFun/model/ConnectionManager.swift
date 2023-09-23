//
//  ConnectionManager.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/22/23.
//

import Foundation

class ConnectionManager: ObservableObject {
    @Published var results = [Character]()
    
    let baseURL = "https://gateway.marvel.com:443/v1/public/characters"
    let publicAPIKey = "e2719ae4bb577096eccd880b3764a76a"
    
    // Hard code in the hash for right now; calculated using https://www.md5hashgenerator.com
    let hash = "148b6d3244e70bf5f8840cdcc1529639"
    
    
    func fetchData() {
        //md5(ts+privateKey+publicKey)
        //let hashString = "1"+privateAPIKey+publicAPIKey
        //let md5Hash = hashString.MD5
        
        let urlString = "\(baseURL)?ts=1&apikey=\(publicAPIKey)&hash=\(hash)"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                // TODO: Remove debug print statements
                                print(results.data.count)
                                print(results.data.results)
                                self.results = results.data.results
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
