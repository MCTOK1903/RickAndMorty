//
//  NetworkConstant.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

extension Constant {
    final class NetworkConstant {
        static let baseURL = "https://rickandmortyapi.com/api"
        static let allCharacters = "/character"
        static let getNextCharacterPath = allCharacters + "/?"
    }
}
