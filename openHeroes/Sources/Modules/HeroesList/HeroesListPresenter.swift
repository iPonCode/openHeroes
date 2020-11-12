//  HeroesListPresenter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

// MARK: (View -> Presenter)
protocol HeroesListPresenter {
    
    func viewDidLoad()
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)
    func numberOfRowsInSection() -> Int
    func getCellInfo(indexPath: IndexPath) -> CharacterEntity?

}

class DefaultHeroesListPresenter {
    
    private weak var view: HeroesListView?
    var interactor: HeroesListInteractorInput?
    private let router: HeroesListRouter
    var heroesList: [CharacterEntity] = []
    
    init(interface: HeroesListView,
         interactor: HeroesListInteractorInput?,
         router: HeroesListRouter) {
        
        view = interface
        self.interactor = interactor
        self.router = router
    }
}

extension DefaultHeroesListPresenter: HeroesListPresenter {

    // MARK: Inputs from view
    func viewDidLoad() {
        
        interactor?.loadHeroesList()
    }
    
    func numberOfRowsInSection() -> Int {

        return heroesList.count
    }
    
    func getCellInfo(indexPath: IndexPath) -> CharacterEntity? {

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
    
    func getHeroSuccess(_ hero: CharacterEntity) {
        router.showHeroDetail(hero)
    }
    
    func getHeroFailure() {
    }
    
    func showError(_ message: String?, title: String?) {
        
        view?.endRefreshingView()
        router.showAlert(msg: message ?? "An error has ocurred",
                         title: title ?? "Oops!")
    }
    
    func updateView(list: [CharacterEntity]) {
        
        self.heroesList = list
        view?.refreshView()
    }

}
