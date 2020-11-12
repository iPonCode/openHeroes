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
    func didSelectRow(at indexPath: IndexPath)
    func numberOfRows(at section: Int) -> Int
    func numberOfSections() -> Int
    func getCellInfo(indexPath: IndexPath) -> CharacterEntity?  // TODO: Remove and use configure
    //func configure(cell: HeroesListViewCell, indexPath: IndexPath) // TODO: Cell design

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
    
    func didSelectRow(at indexPath: IndexPath) {
        let item = heroesList[indexPath.row]
        router.showHeroDetail(item)
    }
    
    func numberOfRows(at section: Int) -> Int {
        return section == 0 ? heroesList.count : 0
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func getCellInfo(indexPath: IndexPath) -> CharacterEntity? {
        return heroesList[indexPath.row]
    }
    
//    func configure(cell: HeroesListViewCell, indexPath: IndexPath) {
//        cell.textLabel?.text = heroesList[indexPath.row].description
//    }

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
