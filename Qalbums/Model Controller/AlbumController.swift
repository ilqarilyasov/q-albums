//
//  AlbumController.swift
//  Qalbums
//
//  Created by Ilgar Ilyasov on 2/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    
    private(set) var albums: [Album] = []
    private let baseURL = URL(string: "https://journal-coredata-b5a96.firebaseio.com/")!
    
    
    // MARK: - Networking
    
    func getAlbums(completion: @escaping (Error?) -> Void = { _ in }) {
        let url = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error performing GET data task: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from URLSession")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonDict = try decoder.decode([String: Album].self, from: data)
                self.albums = jsonDict.map{ $0.value }
                completion(nil)
                return
            } catch {
                NSLog("Error decoding firebase to Album: \(error)")
                completion(error)
            }
        }
    }
    
    
    func put(album: Album) {
        let idURL = baseURL.appendingPathComponent(album.id.uuidString)
        let jsonURL = idURL.appendingPathExtension("json")
        
        var request = URLRequest(url: jsonURL)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            let encodedAlbum = try encoder.encode(album)
            request.httpBody = encodedAlbum
        } catch {
            NSLog("Error encoding Album to a JSON: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                NSLog("Error performing PUT data task: \(error)")
                return
            }
            
            if let response = response {
                NSLog("URLSession PUT data task response: \(response)")
                return
            }
        }
    }
    
    
    // MARK: - Testing
    
    @discardableResult
    static func testDecodingExampleAlbum() -> Album? {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            NSLog("Error getting url of example json file")
            return nil
        }
        
        var data = Data()
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            NSLog("Error getting data from URL: \(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            print("Success: \(album)")
            return album
        } catch {
            NSLog("Error decoding Album: \(error)")
            return nil
        }
    }
    
    static func testEncodingExampleAlbum() {
        guard let album = testDecodingExampleAlbum() else {
            NSLog("No album returned")
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(album)
            print("Album successfully endoced: \(encodedData)")
            return
        } catch {
            NSLog("Error ecoding Album: \(error)")
            return
        }
    }
    
}
