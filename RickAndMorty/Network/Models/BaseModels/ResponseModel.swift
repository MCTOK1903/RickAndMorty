//
//  ResponseModel.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

struct ResponseModel<T:Codable>: Codable {
    
    var info: Info?
    var results: T?
    var error: String?
    var rawData: Data?
    var json: String? {
        guard let rawData = rawData else { return nil }
        return String(data: rawData, encoding: String.Encoding.utf8)
    }
    var request: RequestModel?
    
    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        info = (try? keyedContainer.decode(Info.self, forKey: CodingKeys.info))
        results = (try? keyedContainer.decode(T.self, forKey: CodingKeys.results))
        error = (try? keyedContainer.decode(String.self, forKey: CodingKeys.error))
    }
}

// Mark: - Private funcs
extension ResponseModel {
    private enum CodingKeys: String, CodingKey {
        case info = "info"
        case results = "results"
        case error = "error"
    }
}

struct Info: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
