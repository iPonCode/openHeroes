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
    var list: [CharacterListEntity] { get }
}

// MARK: (Interactor -> Presenter)
protocol HeroesListInteractorOutput: AnyObject {
    func updateView()
    func showError(_ message: String?, title: String?, showInUI: Bool)
}

class HeroesListInteractor: HeroesListInteractorInput {

    weak var presenter: HeroesListInteractorOutput?
    let dataManager: MarvelDataManager
    var list: [CharacterListEntity] = []

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
                    case .loadErrorLocal(let error): // TODO: Asume it's because first App run and don't have the file saved yet
                        debugPrint(String(format:"Error: %@", error.localizedDescription))
                        weakSelf.showError("If downloaded data successfully, will locally stored for display faster next time",
                                           title: "First time List load", showInUI: true)
                        
                    case .loadErrorRemote(let error): // TODO: This error can be (no-internet)
                        debugPrint(String(format:"Error: %@", error.localizedDescription))
                        weakSelf.showError("An error occur trying to comunicate with the webservice, will display local data if possible. Please check the internet connection",
                                           title: "Comunication Error loading List", showInUI: true)
                }
            }
        }
    }

}

private extension HeroesListInteractor {
    
    func manageResponse(resp: [MarvelCharacterListItemDTO]) {
        let processedList = resp.compactMap({ CharacterListEntity($0) })
        self.list = processedList
        presenter?.updateView()
    }
    
    func showError(_ message: String = "There was an error",
                   title: String = "Generic Error",
                   showInUI: Bool = false) {
        debugPrint(String(format:"Error: %@. Description: %@", title, message))
        presenter?.showError(message, title: title, showInUI: showInUI)
    }

}
