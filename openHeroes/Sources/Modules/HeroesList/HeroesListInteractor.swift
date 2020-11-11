//  HeroesListInteractor.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

// MARK: (Presenter -> Interactor)
protocol HeroesListInteractorInput: class {
    
    var presenter: HeroesListInteractorOutput? { get set }
    
    func loadHeroesList(completion complete: @escaping (HeroesListInteractorResult) -> Void)
    func retrieveHero(at index: Int)
}

// MARK: (Interactor -> Presenter)
protocol HeroesListInteractorOutput: class {
    
    func fetchHeroesListSuccess(heroes: [CharacterEntity])
    func fetchHeroesListFailure(error: String)
    
    func getHeroSuccess(_ hero: MarvelCharacterListItemDTO)
    func getHeroFailure()
    
}

enum HeroesListInteractorError: Error {
    case nilData
    case networkError(Error)
}

typealias HeroesListInteractorResult = Result<[CharacterEntity], HeroesListInteractorError>

class HeroesListInteractor: HeroesListInteractorInput {

    // MARK: Properties
    weak var presenter: HeroesListInteractorOutput?
    let dataManager: MarvelDataManager
    
    init(dataManager: MarvelDataManager) {
        self.dataManager = dataManager
    }
    
    func loadHeroesList(completion complete: @escaping (HeroesListInteractorResult) -> Void) {
    
        dataManager.load() { result in
            
            switch result {
            
            case .success(let dto):
                
                guard let data = dto.data else {
                    complete(.failure(.nilData))
                    return
                }
                complete(.success(data.results.compactMap({ CharacterEntity($0) })))
                
            
            case .failure(let error):
                complete(.failure(.networkError(error)))
            }
        }

    }

    func retrieveHero(at index: Int) {
        
        // TODO: Retrieve a hero
    }

}

