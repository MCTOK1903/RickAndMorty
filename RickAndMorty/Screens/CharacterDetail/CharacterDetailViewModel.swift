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
        calculateTotalEpisodesCount()
        findLastSeenEpisode()
        delegate?.showDetail(character)
    }
    
    func calculateTotalEpisodesCount() {
        self.character.totalEpisodesCount = self.character.episode.count
    }
    
    func findLastSeenEpisode() {
        let splitSting = self.character.episode.last?.components(separatedBy: "/")
        self.character.lastSeenEpisodeName = splitSting?.last
    }
}
