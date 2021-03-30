//
//  ErrorModel.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

enum ErrorKey: String {
    case general = "Error_general"
    case parsing = "Error_parsing"
}

public class ErrorModel: Error {
    
    // MARK: Properties
    
    var messageKey: String
    var message: String {
        return messageKey
    }
    
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: public func
extension ErrorModel {
    class func genealError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }
}
