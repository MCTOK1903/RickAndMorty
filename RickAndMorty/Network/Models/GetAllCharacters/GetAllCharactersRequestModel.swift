//
//  GetAllCharacters.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

class GetAllCharactersReqestModel: RequestModel {
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override var path: String {
        return Constant.NetworkConstant.allCharacters
    }
}
