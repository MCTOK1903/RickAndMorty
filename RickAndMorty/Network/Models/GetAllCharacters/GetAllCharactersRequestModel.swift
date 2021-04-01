//
//  GetAllCharacters.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

class GetAllCharactersReqestModel: RequestModel {
    
    private var url: String?
    
    init(url: String? = nil) {
        self.url = url
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override var path: String {
        if let url = url {
            return url
        }  else {
            return Constant.NetworkConstant.allCharacters
        }
    }
}
