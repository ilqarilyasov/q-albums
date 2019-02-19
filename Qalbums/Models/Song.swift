//
//  Song.swift
//  Qalbums
//
//  Created by Ilgar Ilyasov on 2/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Song: Codable {
    
    // MARK: - Properties
    
    let duration: String
    let id: UUID
    let title: String
    
    
    // MARK: - Initializer
    
    init(duration: String, id: UUID = UUID(), title: String) {
        self.duration = duration
        self.id = id
        self.title = title
    }
    
    
    // MARK: - CodingKeys
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    enum DurationKeys: String, CodingKey {
        case duration
    }
    
    enum NameKeys: String, CodingKey {
        case title
    }
    
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
        let title = try nameContainer.decode(String.self, forKey: .title)
        
        self.id = id
        self.duration = duration
        self.title = title
    }
    
    
    // MARK: - Encodable
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        
        var durationContainer = container.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
        try nameContainer.encode(title, forKey: .title)
    }
    
}
