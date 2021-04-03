//
//  ResourcesLoader.swift
//  RickAndMortyTests
//
//  Created by Celal Tok on 3.04.2021.
//

import Foundation
@testable import RickAndMorty

class ResourceLoader {
    
    static func loadCharacter() throws -> [GetAllCharactersResponseModel]{
        let bundle = Bundle.test
        let url = bundle.url(forResource: "Character", withExtension: ".json")!
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let launches = try decoder.decode([GetAllCharactersResponseModel].self, from: data)
        return launches
    }
}

private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
