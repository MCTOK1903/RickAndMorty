//
//  RequestModel.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation

enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class RequestModel: NSObject, Codable {
    
    // MARK: Properties
    
    var path: String {
        return ""
    }
    
    var isId: Bool {
        return false
    }
    
    var parameters: [String: Any?] {
        return [:]
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var method: RequestHTTPMethod {
        return body.isEmpty ? RequestHTTPMethod.get : RequestHTTPMethod.post
    }
    
    var body: [String: Any?] {
        return [:]
    }
}

// MARK: - public func

extension RequestModel {
    
    func urlRequest() -> URLRequest {
        var endpoint: String = Constant.NetworkConstant.baseURL.appending(path)
        
        for parameter in parameters {
            if let value = parameter.value as? String {
                endpoint.append("?\(parameter.key)=\(value)")
            }
        }
        print(endpoint)
        
        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)
        
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                // TODO: Handle Error
                print("error = \(error.localizedDescription)")
            }
        }
        return request
    }
}
