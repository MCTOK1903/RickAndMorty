//
//  Services.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

protocol ServiceType {
    
    typealias completionHandler<T> = Swift.Result<T, ErrorModel>
    
    func getAllCharacters(completion: @escaping(completionHandler<[GetAllCharactersResponseModel]>) -> Void)
    
    func getCharacterr(characterId: Int, completion: @escaping(completionHandler<GetAllCharactersResponseModel>) -> Void)
    
    func filterCharacter(characterStatus: CharacterStatus, completion: @escaping(completionHandler<[GetAllCharactersResponseModel]>) -> Void)
}

public class Services: ServiceType {

    //  T = ResponseMoodel Type
    typealias completionHandler<T> = Swift.Result<T, ErrorModel>
        
    func getAllCharacters(completion: @escaping(completionHandler<[GetAllCharactersResponseModel]>) -> Void) {
        ServiceManager.shared.sendRequest(request: GetAllCharactersReqestModel()) { (result) in
            completion(result)
        }
    }
    
    func getCharacterr(characterId: Int, completion: @escaping(completionHandler<GetAllCharactersResponseModel>) -> Void) {
        ServiceManager.shared.getCharacter(request: GetCharacterRequestModel(characterId: characterId)) { (result) in
            completion(result)
        }
    }
    
    func filterCharacter(characterStatus: CharacterStatus, completion: @escaping(completionHandler<[GetAllCharactersResponseModel]>) -> Void) {
        ServiceManager.shared.sendRequest(request: GetFilterRequestModel(status: characterStatus)) { (result) in
            completion(result)
        }
    }
}
