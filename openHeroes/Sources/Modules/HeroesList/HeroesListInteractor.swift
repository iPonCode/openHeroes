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
    
        dataManager.loadHeroesList() { [weak self] result in
            
            guard let weakSelf = self else { return }
            
            switch result {
            
            case .success(let dto):
                
                guard let data = dto.data else {
                    weakSelf.showError("Nil data was found", title: "No Data")
                    return
                }
                weakSelf.manageResponse(resp: data.results)
                
            case .failure(let error):
                switch error {
                case .loadError(let error):
                    weakSelf.showError("Description: \(error)", title: "Load error")
                }
            }
        }

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
