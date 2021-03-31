//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Celal Tok on 31.03.2021.
//

import Foundation

final class CharacterListViewModel: CharacterListViewModelType {
    
    // MARK: Properties
    
    var delegate: CharacterListViewModelDelegate?
    private var service: ServiceType
    private var characters: [GetAllCharactersResponseModel] = []
    
    // MARK: Init
    
    init(service: ServiceType) {
        self.service = service
    }
    
    // MARK: Funcs
    
    func selectCharacter(with character: GetAllCharactersResponseModel) {
        let viewModel = CharacterDetailViewModel(character: character)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    func loadAllCharacter() {
        notify(.updateTitle("RickAndMorty"))
        
        notify(.setLoading(true))
        
        service.getAllCharacters { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let characters):
                self.characters = characters
                self.notify(.showCharacterList(self.characters))
            case .failure(let error):
                print("Error -> \(error)")
            }
        }
    }
    
    
    
    private func notify(_ output: CharacterListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
