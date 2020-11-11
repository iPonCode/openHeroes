//  WebService.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation
import Alamofire

enum WebServiceError: Error {
    case invalidUrl
    case noData
    case networkError(Error)
    case jsonParseError(Error)
}

protocol WebService {
    
    func getData<T>(urlString: String, completion complete: @escaping (Result<T, WebServiceError>) -> Void) where T: Codable
}


class DefaultWebService: WebService {

    func getData<T>(urlString: String, completion complete: @escaping (Result<T, WebServiceError>) -> Void) where T: Codable {

        guard let url = URL(string: urlString) else {
            complete(.failure(.invalidUrl))
            return
        }
        
        AF.request(url).responseData { response in
            
            switch response.result {
            
            case .success(let serverResponse):
                if let code = response.response?.statusCode {
                    switch code {
                    case 200...299:
                        do {
                            complete(.success(try JSONDecoder().decode(T.self, from: serverResponse)))
                        } catch let error {
                            NSLog(String(data: serverResponse, encoding: .utf8) ?? "nothing received")
                            complete(.failure(.jsonParseError(error)))
                        }
                    default:
                        let error = NSError(domain: response.debugDescription, code: code, userInfo:
                                                response.response?.allHeaderFields as? [String: Any])
                        complete(.failure(.networkError(error)))
                    }
                }
                
            case .failure(let error):
                complete(.failure(.networkError(error)))
            }
            
        }
    }
    
}
