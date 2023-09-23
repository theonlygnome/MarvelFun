//
//  ConnectionManager.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/22/23.
//

import Foundation

class ConnectionManager: ObservableObject {
    @Published var characterResults = [Character]()
    @Published var comicResults = [Comic]()
    @Published var eventResults = [Event]()
    
    private var page = 0
    private let limit = 20
    
    let baseURL = "https://gateway.marvel.com:443/v1/public/characters"

    func loadMoreCharacters() {
        fetchCharacterData()
    }
    
    func fetchCharacterData() {
               
        let offset = page * limit
        let urlString = "\(baseURL)?ts=1&apikey=\(publicKey())&hash=\(md5Hash())&offset=\(offset)"
        
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(CharacterResults.self, from: safeData)
                            DispatchQueue.main.async {
                                for result in results.data.results {
                                    self.characterResults.append(result)
                                }
                                self.page += 1
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
    
    
    func fetchComicData(_ id: Int) {

        let urlString = "\(baseURL)/\(String(id))/comics?ts=1&apikey=\(publicKey())&hash=\(md5Hash())"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(ComicResults.self, from: safeData)
                            DispatchQueue.main.async {
                                self.comicResults = results.data.results
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
    
    func fetchEventData(_ id: Int) {
        
        let urlString = "\(baseURL)/\(String(id))/events?ts=1&apikey=\(publicKey())&hash=\(md5Hash())"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(EventResults.self, from: safeData)
                            DispatchQueue.main.async {
                                self.eventResults = results.data.results
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
    
    func configurationPlist() -> [String: Any]? {
        var config: [String: Any]?
                
        if let infoPlistPath = Bundle.main.url(forResource: "Configuration", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }

        return config
    }
    
    // MD5 hash is hard coded in the configuration plist; calculated using https://www.md5hashgenerator.com
    // md5 = "1"+privateAPIKey+publicAPIKey
    func md5Hash() -> String {
        if let config = configurationPlist() {
            if let hash = config["md5 hash"] as? String {
                return hash
            }
        }
        // Should probably be an error
        return "0";
    }
    
    func publicKey() -> String {
        if let config = configurationPlist() {
            if let publicKey = config["Public Key"] as? String {
                return publicKey
            }
        }
        // Should be an error
        return "0"
    }
}
