//  HeroesListPresenter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

// MARK: (View -> Presenter)
protocol HeroesListPresenter: class {
    
    var view: HeroesListView? { get set }
    var interactor: HeroesListInteractorInput? { get set }
    var router: HeroesListRouter? { get set }
    var heroesList: [CharacterListItemDTO]? { get set }
    
    func viewDidLoad()
    func refresh()
    func numberOfRowsInSection() -> Int
    func getCellInfo(indexPath: IndexPath) -> CharacterListItemDTO?
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)

}

class DefaultHeroesListPresenter: HeroesListPresenter {
    
    weak var view: HeroesListView?
    var interactor: HeroesListInteractorInput?
    var router: HeroesListRouter?
    var heroesList: [CharacterListItemDTO]?

    // MARK: Inputs from view
    func viewDidLoad() {
        view?.showProgress()
        interactor?.loadHeroesList()
    }
    
    func refresh() {
        interactor?.loadHeroesList()
    }
    
    func numberOfRowsInSection() -> Int {

        guard let heroesList = self.heroesList else {
            return 0
        }
        return heroesList.count
    }
    
    func getCellInfo(indexPath: IndexPath) -> CharacterListItemDTO? {

        guard let heroesList = self.heroesList else {
            return nil
        }
        return heroesList[indexPath.row]
    }

    func didSelectRowAt(index: Int) {
        interactor?.retrieveHero(at: index)
    }
    
    func deselectRowAt(index: Int) {
        view?.deselectRowAt(row: index)
    }
    
}


// MARK: - Outputs to view
extension DefaultHeroesListPresenter: HeroesListInteractorOutput {

    func fetchHeroesListSuccess(heroes: [CharacterListItemDTO]) {

        self.heroesList = heroes
        view?.hideProgress()
        view?.onFetchHeroesListSuccess()
    }
    
    func fetchHeroesListFailure(errorResponse: ErrorResponse) {

        view?.hideProgress()
        view?.onFetchHeroesListFailure(error: "Couldn't fetch Heroes List. Error: \(errorResponse.message) (code: \(errorResponse.code))")
    }
    
    func getHeroSuccess(_ hero: CharacterListItemDTO) {
        router?.pushToHeroDetail(on: view!, with: hero.id)
    }
    
    func getHeroFailure() {
        view?.hideProgress()
    }

}
