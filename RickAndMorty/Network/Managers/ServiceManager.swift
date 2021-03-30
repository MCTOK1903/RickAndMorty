//
//  ServiceManager.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import Foundation
import Alamofire

class ServiceManager {
    
    // MARK: Properties
    
    public static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {
    
    func sendRequest<T:Codable>(request:RequestModel,completion: @escaping(Swift.Result<T, ErrorModel>)-> Void) {
        
        AF.request(request.urlRequest()).validate().responseJSON { (response) in
            
            guard let data = response.data, var responseModel = try? JSONDecoder().decode(ResponseModel<T>.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                print(response.error?.localizedDescription ?? "\(ErrorModel(ErrorKey.parsing.rawValue))")
                completion(Result.failure(error))
                return
            }
            
            responseModel.rawData = data
            responseModel.request = request
            
            
            if let results = responseModel.results {
                print("Success")
                completion(Result.success(results))
            }else {
                print(response.error?.errorDescription ?? "\(String(describing: response.error?.errorDescription))")
                print(responseModel.error ?? "!")
                completion(Result.failure(ErrorModel(responseModel.error ?? "\(ErrorModel.genealError())")))
            }
        }
    }
    
    func getCharacter(request:RequestModel,completion: @escaping(Swift.Result<GetAllCharactersResponseModel, ErrorModel>)-> Void) {
        
        AF.request(request.urlRequest()).validate().responseJSON { (response) in
            guard let data = response.data, let responseModel = try? JSONDecoder().decode(GetAllCharactersResponseModel.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                completion(Result.failure(error))
                return
            }
            
            completion(Result.success(responseModel))
            
        }
    }
}
