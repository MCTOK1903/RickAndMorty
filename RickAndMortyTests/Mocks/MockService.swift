//
//  MockService.swift
//  RickAndMortyTests
//
//  Created by Celal Tok on 3.04.2021.
//

import Foundation
@testable import RickAndMorty

final class MockService: ServiceType {
    
    // MARK: Properties
    var characters :[GetAllCharactersResponseModel] = []
    
    // MARK: Funcs
    
    func getAllCharacters(url: String?, pagination: Bool, completion: @escaping (completionHandler<[GetAllCharactersResponseModel]>) -> Void) {
        completion(.success(characters))
    }
    
    func getCharacterr(characterId: Int, completion: @escaping (completionHandler<GetAllCharactersResponseModel>) -> Void) {
        guard let character = self.characters.first  else { return completion(.failure(ErrorModel("")))}
        completion(.success(character))
    }
    
    func filterCharacter(characterStatus: CharacterStatus, completion: @escaping (completionHandler<[GetAllCharactersResponseModel]>) -> Void) {
        completion(.success(characters))
    }
}
