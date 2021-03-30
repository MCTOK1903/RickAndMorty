//
//  GetCharacterREquestModel.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

class GetCharacterRequestModel: RequestModel {
    
    private var characterId: Int
    
    init(characterId: Int) {
        self.characterId = characterId
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override var isId: Bool {
        return true
    }
    
    override var path: String {
        return Constant.NetworkConstant.allCharacters + "/\(self.characterId)"
    }
}
