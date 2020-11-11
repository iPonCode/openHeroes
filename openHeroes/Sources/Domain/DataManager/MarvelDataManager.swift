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

protocol MarvelDataManager: class {

    func load(completion complete: @escaping (MarvelDataManagerResult) -> Void)
}

class DefaultMarvelDataManager: MarvelDataManager {
    let service: MarvelService
    //let storage: MarvelStorage // TODO Storage

    init(service: MarvelService) {
        self.service = service
    }

    func load(completion complete: @escaping (MarvelDataManagerResult) -> Void) {
    
        //if let stored = storage.load() { // TODO Check storage before service
    
        service.load { result in
            
            switch result {
            
            case .failure(_):
                complete(.failure(.loadError))
                
            case .success(let response):
                
                //self?.storage.save // TODO Save in storage if necessary (weak self)
                complete(.success(response))
            }
            
        }
    }

}
