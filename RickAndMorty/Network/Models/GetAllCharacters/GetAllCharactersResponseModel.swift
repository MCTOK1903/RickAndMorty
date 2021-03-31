//
//  GetAllCharactersREsponseModel.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

struct GetAllCharactersResponseModel: Codable, Hashable {
    
    var id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    var isFavorite: Bool?
}

struct Location: Codable, Hashable {
    let name: String
    let url: String
}

enum CharacterStatus: String {
    case dead = "Dead"
    case alive = "Alive"
    case unknown = "unknown"
}
