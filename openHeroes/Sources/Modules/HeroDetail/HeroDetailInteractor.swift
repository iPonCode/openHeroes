//  HeroDetailInteractor.swift
//  openHeroes
//
//  Created by Simón Aparicio on 13/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

// MARK: (Presenter -> Interactor)
protocol HeroDetailInteractorInput {
    func loadHeroDetail()
    var detail: [CharacterDetailEntity] { get }
}

// MARK: (Interactor -> Presenter)
protocol HeroDetailInteractorOutput: AnyObject {
    func updateView()
    func showError(_ message: String?, title: String?, showInUI: Bool)
}

class HeroDetailInteractor: HeroDetailInteractorInput {

    weak var presenter: HeroDetailInteractorOutput?
    let dataManager: MarvelDataManager
    var detail: [CharacterDetailEntity] = []
    var id: Int
    
    init(dataManager: MarvelDataManager, id: Int) {
        self.dataManager = dataManager
        self.id = id
    }
    
    func loadHeroDetail() {
    
        dataManager.loadHeroDetail(id: id) { [weak self] result in
            
            guard let weakSelf = self else { return }
            switch result {
            case .success(let dto):
                guard let data = dto.data else {
                    weakSelf.showError("Nil data was found", title: "No Data", showInUI: true)
                    return
                }
                weakSelf.manageResponse(resp: data.results)
            case .failure(let error):
                switch error {
                    case .loadErrorLocal(let error): // TODO: Asume it's because first time request this id and don't have the file saved yet
                        debugPrint(String(format:"Error: %@", error.localizedDescription))
                        weakSelf.showError("If downloaded data successfully for id:\(weakSelf.id), will locally stored for display faster next time",
                                           title: "First time load Detail for this id", showInUI: true)
                        
                    case .loadErrorRemote(let error): // TODO: This error can be (no-internet)
                        debugPrint(String(format:"Error: %@", error.localizedDescription))
                        weakSelf.showError("An error occur trying to comunicate with the webservice, will display local data if possible. Please check the internet connection",
                                           title: "Comunication Error loading id: id:\(weakSelf.id)", showInUI: true)
                }
            }
        }
    }

}

private extension HeroDetailInteractor {
    
    func manageResponse(resp: [MarvelCharacterDetailDTO]) {
        let processedDetail = resp.compactMap({ CharacterDetailEntity($0) })
        guard let heroDetail = processedDetail.first else { return }
        self.detail = [heroDetail]
        presenter?.updateView()
    }
    
    func showError(_ message: String = "There was an error",
                   title: String = "Generic Error",
                   showInUI: Bool = false) {
        debugPrint(String(format:"Error: %@. Description: %@", title, message))
        presenter?.showError(message, title: title, showInUI: showInUI)
    }
    
}
