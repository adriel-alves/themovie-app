//
//  HttpClientConsumer.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

protocol HTTPClient {
    
    var session: URLSession { get }
    func perform<T: Decodable>(_ request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension HTTPClient {
    
    typealias DecodingHandler = (Decodable?, APIError?) -> Void
    
    func decoding<T: Decodable>(_ request: URLRequest, decodingType: T.Type, _ completion: @escaping DecodingHandler) -> URLSessionDataTask{
        
        let dataTask = self.session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .noRespose)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let model = try JSONDecoder().decode(decodingType.self, from: data)
                        completion(model, nil)
                    } catch  {
                        completion(nil, .decodingFailure)
                    }
                } else {
                    completion(nil, .resposeStatusCode(code: response.statusCode))
                }
            } else {
                completion(nil, .taskError(error: error!))
            }
        }
        return dataTask
    }
    
    func perform<T: Decodable>(_ request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = self.decoding(request, decodingType: T.self) { json, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.invalidJSON))
                }
            }
            
        }
        task.resume()
        
    }
}
