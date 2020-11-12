//  MarvelDataManager.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

enum MarvelDataManagerError: Error {
    case loadError
}

typealias MarvelDataManagerResult = Result<MarvelNetworkResponseDTO, MarvelDataManagerError>
typealias LocalStorageDataSource = MarvelDataSource & SaveLocalDataSource

protocol MarvelDataManager {

    func loadHeroesList(completion complete: @escaping (MarvelDataManagerResult) -> Void)
    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelDataManagerResult) -> Void)
}

class DefaultMarvelDataManager: MarvelDataManager {

    let remote: MarvelDataSource
    let local: LocalStorageDataSource
    // TODO: Storage

    init(remote: MarvelDataSource, local: LocalStorageDataSource) {
        self.remote = remote
        self.local = local
    }

    func loadHeroesList(completion complete: @escaping (MarvelDataManagerResult) -> Void) {
    
       // TODO: Check storage before service
    
        local.loadHeroesList { result in
            
            switch result {
            
            case .failure(_):
                complete(.failure(.loadError))
                
            case .success(let response):
                
                // TODO: Save in storage if necessary
                complete(.success(response))
            }
            
        }
        
        remote.loadHeroesList { result in
            
            switch result {
            
            case .failure(_):
                complete(.failure(.loadError))
                
            case .success(let response):
                
                // TODO: Save in storage if necessary
                complete(.success(response))
            }
            
        }
    }

    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelDataManagerResult) -> Void) {
        // TODO
    }
    
}
