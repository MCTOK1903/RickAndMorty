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
            let character = try decoder.decode(GetAllCharactersResponseModel.self, from: data)
            
            //Projede kullanilacak olanlar test edimistir.
            
            XCTAssertEqual(character.id, 1)
            XCTAssertEqual(character.name, "Rick Sanchez")
            XCTAssertEqual(character.status, "Alive")
            XCTAssertEqual(character.species, "Human")
        } catch {
            XCTFail()
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
