//  HeroesListInteractor.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

class HeroesListInteractor: PresenterToInteractorHeroesListProtocol {

    // MARK: Properties
    weak var presenter: InteractorToPresenterHeroesListProtocol?
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

