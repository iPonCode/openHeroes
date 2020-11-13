//  MarvelDataSource.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

protocol MarvelDataSource {
    func loadHeroesList(completion complete: @escaping (MarvelDataSourceResult) -> Void)
    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelDataSourceResult) -> Void)
}

protocol SaveLocalDataSource {
    func saveHeroesList(_ result: MarvelNetworkResponseDTO, completion complete: @escaping (Bool) -> Void)
    func saveHeroe(_ result: MarvelNetworkResponseDTO, id: Int, completion complete: @escaping (Bool) -> Void)
}

enum DataSourceError: Error {
    case invalidUrl
    case noHeroesData
    case networkError(Error)
    case invalidHeroesData(Error)
    case fileNotFound(Error)
}

typealias MarvelDataSourceResult = Result<MarvelNetworkResponseDTO, DataSourceError>

class RemoteMarvelDataSource: MarvelDataSource {
    
    let netWorkworker: NetworkWorker
    let apiConfig: ApiConfiguration

    init(netWorkworker: NetworkWorker, apiConfiguration: ApiConfiguration) {
        self.netWorkworker = netWorkworker
        self.apiConfig = apiConfiguration
    }

    func loadHeroesList(completion complete: @escaping (MarvelDataSourceResult) -> Void) {
        
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
    
    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelDataSourceResult) -> Void) {
        
        // TODO: Check if it is necessary use an other DTO instead MarvelNetworkResponseDTO
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

    func loadHeroesList(completion complete: @escaping (MarvelDataSourceResult) -> Void) {
        
        do {
            let jsonData = try Data(contentsOf: filePathFor(.heroesList))
            let decodedData: MarvelNetworkResponseDTO = try JSONDecoder().decode(MarvelNetworkResponseDTO.self, from: jsonData)
            complete(.success(decodedData))
        } catch {
            complete(.failure(.fileNotFound(error)))
        }
    }
    
    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelDataSourceResult) -> Void) {
        
        do {
            let jsonData = try Data(contentsOf: filePathFor(.heroeDetail, with: id))
            let decodedData: MarvelNetworkResponseDTO = try JSONDecoder().decode(MarvelNetworkResponseDTO.self, from: jsonData)
            complete(.success(decodedData))
        } catch {
            complete(.failure(.fileNotFound(error)))
        }
    }
    
    func saveHeroesList(_ result: MarvelNetworkResponseDTO, completion complete: @escaping (Bool) -> Void) {
        
        do {
            let jsonData = try JSONEncoder().encode(result)
            try jsonData.write(to: filePathFor(.heroesList))
            complete(true)
        } catch {
            complete(false)
        }
    }
    
    func saveHeroe(_ result: MarvelNetworkResponseDTO, id: Int, completion complete: @escaping (Bool) -> Void) {

        do {
            let jsonData = try JSONEncoder().encode(result)
            try jsonData.write(to: filePathFor(.heroeDetail, with: id))
            complete(true)
        } catch {
            complete(false)
        }
    }
    
    enum FileType {
        case heroesList
        case heroeDetail
    }
    
    private func filePathFor(_ fileType: FileType, with id: Int = 0) -> URL {
        switch fileType {
        case .heroesList:
            return getDocumentsURL(for: AppConstants.FileName.heroesList)
        case .heroeDetail:
            return getDocumentsURL(for: AppConstants.FileName.baseHeroDetail +
                                    String(id) +
                                    AppConstants.FileName.fileExtension)
        }
    }

    private func getDocumentsURL(for file: String) -> URL {
        let urlStr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let url = URL(fileURLWithPath: urlStr! + "/" + file)
        return url
    }
    
}

