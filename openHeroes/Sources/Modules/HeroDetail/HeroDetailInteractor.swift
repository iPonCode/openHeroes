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
    func showError(_ message: String?, title: String?)
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
                case .loadError(let error):
                    debugPrint("Error description: %@", error)
                    weakSelf.showError("Downloaded data locally stored (id:\(weakSelf.id)) for next time", title: "First time load Detail for this id", showInUI: true)
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
        debugPrint("Error: %@. Description: %@", title, message)
        if showInUI { presenter?.showError(message, title: title) }
    }
    
}
