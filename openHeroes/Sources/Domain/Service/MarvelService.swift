//  MarvelService.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

protocol MarvelService {
    
    func load(completion complete: @escaping (MarvelServiceResult) -> Void)
}

enum ServiceError: Error {
    case invalidUrl
    case noHeroesData
    case networkError(Error)
    case invalidHeroesData(Error)
}

typealias MarvelServiceResult = Result<MarvelNetworkResponseDTO, ServiceError>

class DefaultMarvelService: MarvelService {
    
    let webService: WebService
    let loadUrlString: String

    init(webService: WebService, loadUrlString: String) {
        self.webService = webService
        self.loadUrlString = loadUrlString
    }

    func load(completion complete: @escaping (MarvelServiceResult) -> Void) {
        
        webService.getData(urlString: loadUrlString) { (result: Result<MarvelNetworkResponseDTO, WebServiceError>) in

            switch result {
            case .failure(let error):
                switch error {
                case .invalidUrl:
                    complete(.failure(.invalidUrl))
                case .noData:
                    complete(.failure(.noHeroesData))
                case .networkError(let error):
                    complete(.failure(.networkError(error)))
                case .jsonParseError:
                    complete(.failure(.invalidHeroesData(error)))
                }
            case .success(let response):
                complete(.success(response))
            }
        }
    }
    
}
