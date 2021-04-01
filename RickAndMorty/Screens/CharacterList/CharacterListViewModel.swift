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
    private var nextUrl: String = ""
    
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
        
        service.getAllCharacters(url: "", pagination: false) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let characters):
                self.characters.append(contentsOf: characters)
                self.notify(.showCharacterList(self.characters))
            case .failure(let error):
                print("Error -> \(error)")
            }
        }
    }
    
    func getNextCharacters(pagination: Bool, nextUrl: String, completion: @escaping () -> Void) {
        service.getAllCharacters(url: nextUrl, pagination: pagination) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let characters):
                self.characters.append(contentsOf: characters)
                completion()
            case .failure(let error):
                print("Error -> \(error)")
            }
        }
    }
    
    func returnPagination() -> Bool {
        return ServiceManager.shared.isPagination
    }
    
    func returnNextCharacters() -> [GetAllCharactersResponseModel] {
        return self.characters
    }
    
    func returnnextPageUrl() -> String {
        let nextPage = UserDefaults.standard.string(forKey: "nextPage")
    
        let splitString = nextPage?.components(separatedBy: "/")
        
        if let nextPageURL = splitString?.last {
            return nextPageURL
        }
        
        return ""
    }
    
    private func notify(_ output: CharacterListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
