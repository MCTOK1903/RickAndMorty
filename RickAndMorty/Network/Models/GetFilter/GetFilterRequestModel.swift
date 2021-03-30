//
//  GetFilterRequestModel.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

class GetFilterRequestModel: RequestModel {
    
    private let status: CharacterStatus
    
    init(status: CharacterStatus) {
        self.status = status
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override var parameters: [String : Any?] {
        return [
            "status": self.status.rawValue
        ]
    }
    
    override var path: String {
        return Constant.NetworkConstant.allCharacters
    }
}
