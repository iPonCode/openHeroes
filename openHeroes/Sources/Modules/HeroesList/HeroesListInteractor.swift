//  HeroesListInteractor.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

// MARK: (Presenter -> Interactor)
protocol HeroesListInteractorInput {
    
    func loadHeroesList()
    func retrieveHero(at index: Int)
}

// MARK: (Interactor -> Presenter)
protocol HeroesListInteractorOutput: AnyObject {
    
    func getHeroSuccess(_ hero: CharacterEntity)
    func getHeroFailure()
    
    func updateView(list: [CharacterEntity])
    func showError(_ message: String?, title: String?)
}

class HeroesListInteractor: HeroesListInteractorInput {

    weak var presenter: HeroesListInteractorOutput?
    let dataManager: MarvelDataManager
    
    init(dataManager: MarvelDataManager) {
        self.dataManager = dataManager
    }
    
    func loadHeroesList() {
    
        dataManager.load() { [weak self] result in
            
            switch result {
            
            case .success(let dto):
                
                guard let data = dto.data else {
                    self?.showError("Nil data was found", title: "No Data")
                    return
                }
                self?.manageResponse(resp: data.results)
                
            case .failure(let error):
                self?.showError("\(error)", title: "Network Error")
            }
        }

    }

    func retrieveHero(at index: Int) {
        
        // TODO: Retrieve a hero
    }

}

private extension HeroesListInteractor {
    
    func manageResponse(resp: [MarvelCharacterListItemDTO]) {
        
        let processedList = resp.compactMap({ CharacterEntity($0) })
        presenter?.updateView(list: processedList)
    }
    
    func showError(_ message: String? = "There was an error",
                   title: String? = "Generic Error") {
        
        presenter?.showError(message, title: title)
    }
    
}
