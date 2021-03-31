//
//  CharacterDetailViewModelType.swift
//  RickAndMorty
//
//  Created by Celal Tok on 1.04.2021.
//

import Foundation

protocol CharacterDetailViewModelType {
    var delegate: CharacterDetailViewModelDelegate? { get set }
    func load()
}

protocol CharacterDetailViewModelDelegate {
    func showDetail(_ character: GetAllCharactersResponseModel)
}
