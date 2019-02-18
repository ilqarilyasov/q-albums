//
//  AlbumController.swift
//  Qalbums
//
//  Created by Ilgar Ilyasov on 2/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    static func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            NSLog("Error getting url of example json file")
            return
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
        } catch {
            NSLog("Error decoding Album: \(error)")
        }
    }
    
}
