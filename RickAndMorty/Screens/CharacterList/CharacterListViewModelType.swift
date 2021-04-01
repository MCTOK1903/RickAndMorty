//
//  CharacterListViewModelType.swift
//  RickAndMorty
//
//  Created by Celal Tok on 31.03.2021.
//

import Foundation

protocol CharacterListViewModelType {
    var delegate: CharacterListViewModelDelegate? { get set }
    func loadAllCharacter()
    func selectCharacter(with character: GetAllCharactersResponseModel)
    func getNextCharacters(pagination: Bool, nextUrl: String, completion: @escaping () -> Void)
    func returnNextCharacters() -> [GetAllCharactersResponseModel]
    func returnPagination() -> Bool
    func returnnextPageUrl() -> String
}

protocol CharacterListViewModelDelegate {
    func handleViewModelOutput(_ output: CharacterListViewModelOutput)
    func navigate(to route: ChracterListRoute)
}

enum CharacterListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showCharacterList([GetAllCharactersResponseModel])
}

enum ChracterListRoute {
    // TODO: add (detailType)
    case detail(CharacterDetailViewModelType)
}
