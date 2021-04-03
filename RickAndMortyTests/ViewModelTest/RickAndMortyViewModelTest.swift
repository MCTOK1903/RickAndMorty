//
//  RickAndMortyViewModelTest.swift
//  RickAndMortyTests
//
//  Created by Celal Tok on 3.04.2021.
//

import XCTest
@testable import RickAndMorty

class RickAndMortyViewModelTest: XCTestCase {
    
    private var view: MockView!
    private var viewModel: CharacterListViewModelType!
    private var service: MockService!
    
    override func setUp() {
        
        view = MockView()
        service = MockService()
        viewModel = CharacterListViewModel(service: service)
        
        viewModel.delegate = view
    }

    func testExample() throws {
        //Given:
        
        let characters = try ResourceLoader.loadCharacter()
        service.characters = characters
        
        // When:
        
        viewModel.loadAllCharacter()
        
        //Then:
        
        XCTAssertEqual(view.outputs.count, 4)
        
        switch view.outputs[0] {
        case .updateTitle(_):
            break //success
        default:
            XCTFail("First output should be updateTitle")
        }
        
        XCTAssertEqual(view.outputs[1], .setLoading(true))
        XCTAssertEqual(view.outputs[2], .setLoading(false))
        
        XCTAssertEqual(view.outputs[3], .showCharacterList(characters))
    }

}
