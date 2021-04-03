//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Celal Tok on 30.03.2021.
//

import XCTest
@testable import RickAndMorty

class RickAndMortyTests: XCTestCase {

    func testParsing() throws {
        do {
            let bundle = Bundle(for: RickAndMortyTests.self)
            guard let url = bundle.url(forResource: "Character", withExtension: "json") else {
                XCTFail()
                return
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let character = try decoder.decode([GetAllCharactersResponseModel].self, from: data)
            
            //Projede kullanilacak olanlar test edimistir.
            XCTAssertEqual(character.first?.id, 1)
            XCTAssertEqual(character.first?.name, "Rick Sanchez")
            XCTAssertEqual(character.first?.status, .alive)
            XCTAssertEqual(character.first?.species, "Human")
        } catch {
            XCTFail()
        }
    }
}
