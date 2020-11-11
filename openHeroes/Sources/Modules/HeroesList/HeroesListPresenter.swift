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
    var heroesList: [CharacterEntity]? { get set }
    
    func viewDidLoad()
    func refresh()
    func numberOfRowsInSection() -> Int
    func getCellInfo(indexPath: IndexPath) -> CharacterEntity?
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)

}

class DefaultHeroesListPresenter: HeroesListPresenter {
    
    weak var view: HeroesListView?
    var interactor: HeroesListInteractorInput?
    var router: HeroesListRouter?
    var heroesList: [CharacterEntity]?

    // MARK: Inputs from view
    func viewDidLoad() {
        
        view?.showProgress()
        interactor?.loadHeroesList() { [weak self] result in
            
        switch result {
        
            case .success(let chartys):
                debugPrint("This is the HeroList in presenter: \(chartys)")
                self?.fetchHeroesListSuccess(heroes: chartys)

            case .failure(let error):
                debugPrint("Something wrong in presenter: \(error)")
            }
        }
    }
    
    func refresh() {
//        interactor?.loadHeroesList()
    }
    
    func numberOfRowsInSection() -> Int {

        guard let heroesList = self.heroesList else {
            return 0
        }
        return heroesList.count
    }
    
    func getCellInfo(indexPath: IndexPath) -> CharacterEntity? {

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

    func fetchHeroesListSuccess(heroes: [CharacterEntity]) {

        self.heroesList = heroes
        view?.hideProgress()
        view?.onFetchHeroesListSuccess()
    }
    
    func fetchHeroesListFailure(error: String) {

        view?.hideProgress()
        view?.onFetchHeroesListFailure(error: "Couldn't fetch Heroes List. Error: \(error)")
    }
    
    func getHeroSuccess(_ hero: MarvelCharacterListItemDTO) {
        router?.pushToHeroDetail(on: view!, with: hero.id)
    }
    
    func getHeroFailure() {
        view?.hideProgress()
    }

}
