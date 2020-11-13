//  MarvelDataManager.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

enum MarvelDataManagerError: Error {
    case loadError(Error)
}

typealias MarvelListDataManagerResult = Result<MarvelListNetworkResponseDTO, MarvelDataManagerError>
typealias MarvelDetailDataManagerResult = Result<MarvelDetailNetworkResponseDTO, MarvelDataManagerError>
typealias LocalStorageDataSource = MarvelDataSource & SaveLocalDataSource

protocol MarvelDataManager {
    func loadHeroesList(completion complete: @escaping (MarvelListDataManagerResult) -> Void)
    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelDetailDataManagerResult) -> Void)
}

class DefaultMarvelDataManager: MarvelDataManager {

    let remote: MarvelDataSource
    let local: LocalStorageDataSource

    init(remote: MarvelDataSource, local: LocalStorageDataSource) {
        self.remote = remote
        self.local = local
    }

    func loadHeroesList(completion complete: @escaping (MarvelListDataManagerResult) -> Void) {
        
        local.loadHeroesList { result in
            switch result {
                case .failure(let error):
                    complete(.failure(.loadError(error)))
                case .success(let response):
                    complete(.success(response))
            }
        }
        remote.loadHeroesList { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
                case .failure(let error):
                    complete(.failure(.loadError(error)))
                case .success(let response):
                    weakSelf.local.saveHeroesList(response) { (success) in
                        // TODO: Check if it is successfuly saved
                    }
                    complete(.success(response))
            }
        }
    }

    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelDetailDataManagerResult) -> Void) {

        local.loadHeroDetail(id: id) { result in
            switch result {
                case .failure(let error):
                    complete(.failure(.loadError(error)))
                case .success(let response):
                    complete(.success(response))
            }
        }
        remote.loadHeroDetail(id: id) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
                case .failure(let error):
                    complete(.failure(.loadError(error)))
                case .success(let response):
                    weakSelf.local.saveHeroe(response, id: id) { (success) in
                        // TODO: Check if it is successfuly saved
                    }
                    complete(.success(response))
            }
        }
    }
    
}
