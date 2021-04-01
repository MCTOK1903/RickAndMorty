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
    
    var isPagination = false
    let defaults = UserDefaults.standard
}

extension ServiceManager {
    
    func sendRequest<T:Codable>(pagination:Bool = false , request:RequestModel,completion: @escaping(Swift.Result<T, ErrorModel>)-> Void) {
        if isPagination {
            isPagination = true
        }
        
        AF.request(request.urlRequest()).validate().responseJSON { (response) in
            
            guard let data = response.data, var responseModel = try? JSONDecoder().decode(ResponseModel<T>.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                print(response.error?.localizedDescription ?? "\(ErrorModel(ErrorKey.parsing.rawValue))")
                completion(Result.failure(error))
                return
            }
            
            responseModel.rawData = data
            responseModel.request = request
            
            
            if let results = responseModel.results, let nextPage = responseModel.info?.next {
                self.defaults.set(nextPage, forKey: "nextPage")
                completion(Result.success(results))
            }else {
                print(response.error?.errorDescription ?? "\(String(describing: response.error?.errorDescription))")
                print(responseModel.error ?? "!")
                completion(Result.failure(ErrorModel(responseModel.error ?? "\(ErrorModel.genealError())")))
            }
            
            if pagination {
                self.isPagination = false
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
