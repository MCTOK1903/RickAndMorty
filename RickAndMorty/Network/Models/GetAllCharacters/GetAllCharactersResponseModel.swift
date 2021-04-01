//
//  GetAllCharactersREsponseModel.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

struct GetAllCharactersResponseModel: Codable, Hashable {
    
    var id: Int
    let name, species, type: String
    let status: CharacterStatus
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    var isFavorite: Bool?
    var totalEpisodesCount: Int?
    var lastSeenEpisodeName: String?
}

struct Location: Codable, Hashable {
    let name: String
    let url: String
}

enum CharacterStatus: String, Codable {
    case dead = "Dead"
    case alive = "Alive"
    case unknown = "unknown"
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        
        switch label {
        case "Dead":
            self = .dead
        case "Alive":
            self = .alive
        case "unknown":
            self = .unknown
        default:
            self = .unknown
        }
    }
}
