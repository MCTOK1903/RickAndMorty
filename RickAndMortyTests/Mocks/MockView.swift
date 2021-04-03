//
//  MockView.swift
//  RickAndMortyTests
//
//  Created by Celal Tok on 3.04.2021.
//

import Foundation
@testable import RickAndMorty

final class MockView: CharacterListViewModelDelegate {
    
    // MARK: Properties
    
    var outputs: [CharacterListViewModelOutput] = []
    
    // MARK: Funcs
    
    func handleViewModelOutput(_ output: CharacterListViewModelOutput) {
        outputs.append(output)
    }
    
    func navigate(to route: ChracterListRoute) {
        
    }
}
