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
    
    func loadHeroesList()
    func retrieveHero(at index: Int)
}

// MARK: (Interactor -> Presenter)
protocol HeroesListInteractorOutput: class {
    
    func fetchHeroesListSuccess(heroes: [CharacterListItemDTO])
    func fetchHeroesListFailure(errorResponse: ErrorResponse)
    
    func getHeroSuccess(_ hero: CharacterListItemDTO)
    func getHeroFailure()
    
}

class HeroesListInteractor: HeroesListInteractorInput {

    // MARK: Properties
    weak var presenter: HeroesListInteractorOutput?
    var heroes: [CharacterListItemDTO]?
    
    func loadHeroesList() {
        
        // TODO: REQUEST WEB SERVICE
        
            // SUCCESS
//            self.heroes = characters
//            self.presenter?.fetchHeroesListSuccess(heroes: characters)
        
            // FAILURE
            let errorObject = ErrorResponse(code: "000", message: "Generic Error")
            self.presenter?.fetchHeroesListFailure(errorResponse: errorObject)
        }

    func retrieveHero(at index: Int) {
        
        guard let heroes = self.heroes,
              heroes.indices.contains(index) else {
            self.presenter?.getHeroFailure()
            return
        }
        self.presenter?.getHeroSuccess(self.heroes![index])
    }

}

