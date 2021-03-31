//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Celal Tok on 1.04.2021.
//

import Foundation

final class CharacterDetailViewModel: CharacterDetailViewModelType {
    
    // MARK: Properties
    
    var delegate: CharacterDetailViewModelDelegate?
    private var character: GetAllCharactersResponseModel
    
    // MARK: init
    
    init(character: GetAllCharactersResponseModel) {
        self.character = character
    }
    
    // MARK: Funcs
    
    func load() {
        delegate?.showDetail(character)
    }
}
