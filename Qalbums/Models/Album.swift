//
//  Album.swift
//  Qalbums
//
//  Created by Ilgar Ilyasov on 2/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    // MARK: - Properties
    
    let artist: String
    let coverArtURLs: [URL]
    let genres: [String]
    let id: UUID
    let name: String
    let songs: [Song]
    
    
    // MARK: - CodingKeys
    
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
    
    // MARK: - Decodable
    
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
        self.coverArtURLs = coverArtURLs
        self.genres = genres
        self.songs = songs
    }
    
    
    // MARK: - Encodable
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try container.encode(artist, forKey: .artist)
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(name, forKey: .name)
        
        var covertArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        for coverArtURL in coverArtURLs {
            var lowerCovertArtContainer = covertArtContainer.nestedContainer(keyedBy: CoverArtKeys.self)
            try lowerCovertArtContainer.encode(coverArtURL, forKey: .url)
        }
        
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        
        for genre in genres {
            try genresContainer.encode(genre)
        }
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        
        for song in songs {
            try songsContainer.encode(song)
        }
    }
    
}
