//
//  Album.swift
//  Qalbums
//
//  Created by Ilgar Ilyasov on 2/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    let coverArtURL: [URL]
    let genres: [String]
    let id: UUID
    let name: String
    let songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
    }
    
    enum CoverArtKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        let artist = try container.decode(String.self, forKey: .artist)
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            let lowerCoverArtContainer = try coverArtContainer.nestedContainer(keyedBy: CoverArtKeys.self)
            let coverArtURL = try lowerCoverArtContainer.decode(URL.self, forKey: .url)
            coverArtURLs.append(coverArtURL)
        }
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genres: [String] = []
        
        while !genresContainer.isAtEnd {
            let genre = try genresContainer.decode(String.self)
            genres.append(genre)
        }
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songs: [Song] = []
        
        while !songsContainer.isAtEnd {
            let song = try songsContainer.decode(Song.self)
            songs.append(song)
        }
        
        
        self.artist = artist
        self.id = id
        self.name = name
        self.coverArtURL = coverArtURLs
        self.genres = genres
        self.songs = songs
    }
}
