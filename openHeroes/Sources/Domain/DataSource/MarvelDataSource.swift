//  MarvelDataSource.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

protocol MarvelDataSource {
    func loadHeroesList(completion complete: @escaping (MarvelServiceResult) -> Void)
    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelServiceResult) -> Void)
}

protocol SaveLocalDataSource {
    func saveHeroesList(_ result: MarvelNetworkResponseDTO, completion complete: @escaping (Bool) -> Void)
    func saveHeroe(_ result: MarvelNetworkResponseDTO, id: Int, completion complete: @escaping (Bool) -> Void)
}

enum ServiceError: Error {
    case invalidUrl
    case noHeroesData
    case networkError(Error)
    case invalidHeroesData(Error)
}

typealias MarvelServiceResult = Result<MarvelNetworkResponseDTO, ServiceError>

class RemoteMarvelDataSource: MarvelDataSource {
    
    let netWorkworker: NetworkWorker
    let apiConfig: ApiConfiguration

    init(netWorkworker: NetworkWorker, apiConfiguration: ApiConfiguration) {
        self.netWorkworker = netWorkworker
        self.apiConfig = apiConfiguration
    }

    func loadHeroesList(completion complete: @escaping (MarvelServiceResult) -> Void) {
        
        netWorkworker.getData(urlString: apiConfig.getCharactersListUrl()) { (result: Result<MarvelNetworkResponseDTO, NetworkWorkerError>) in

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
    
    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelServiceResult) -> Void) {
        
        // TODO: Check if it is necessary change MarvelNetworkResponseDTO
        netWorkworker.getData(urlString: apiConfig.getCharactersListUrl()) { (result: Result<MarvelNetworkResponseDTO, NetworkWorkerError>) in

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


class LocalMarvelDataSource: MarvelDataSource, SaveLocalDataSource {

    func loadHeroesList(completion complete: @escaping (MarvelServiceResult) -> Void) {
        // TODO
    }
    
    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelServiceResult) -> Void) {
        // TODO
    }
    
    func saveHeroesList(_ result: MarvelNetworkResponseDTO, completion complete: @escaping (Bool) -> Void) {
        // TODO
    }
    
    func saveHeroe(_ result: MarvelNetworkResponseDTO, id: Int, completion complete: @escaping (Bool) -> Void) {
        // TODO
    }
    
}

