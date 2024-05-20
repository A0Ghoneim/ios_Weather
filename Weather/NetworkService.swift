//
//  NetworkService.swift
//  Weather
//
//  Created by user242921 on 5/17/24.
//

import Foundation


import Alamofire

protocol NetworkProtocol {
    func fetchDataWithLatAndLong<T: Decodable>(lat : Double,long :Double,decodingType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void)
}

class NetworkServices: NetworkProtocol {
    
    func fetchDataWithLatAndLong<T: Decodable>(lat : Double,long :Double,decodingType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let urlString = "\(Constants.baseURL)/forecast.json?key=\(Constants.apiKey)&q=\(lat),\(long)&days=3&aqi=no&alerts=no"
        print(urlString)
        AF.request(urlString).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                print("sucess")
                completionHandler(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure(error))
            }
        }
    }

    
}

