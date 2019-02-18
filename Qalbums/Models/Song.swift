//
//  Song.swift
//  Qalbums
//
//  Created by Ilgar Ilyasov on 2/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Song: Decodable {
    let duration: String
    let id: UUID
    let title: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case title
    }
    
    enum DurationKeys: String, CodingKey {
        case duration
    }
    
    enum NameKeys: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameKeys.self, forKey: .title)
        let title = try nameContainer.decode(String.self, forKey: .title)
        
        self.id = id
        self.duration = duration
        self.title = title
    }
}
