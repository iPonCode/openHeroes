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
    func configure(_ cell: HeroesListViewCell, at indexPath: IndexPath) // TODO: Cell design

}

class DefaultHeroesListPresenter {
    
    private weak var view: HeroesListView?
    var interactor: HeroesListInteractorInput?
    private let router: HeroesListRouter
    var heroesList: [CharacterListEntity] = []
    
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
        return heroesList.count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func configure(_ cell: HeroesListViewCell, at indexPath: IndexPath) {
        let item = heroesList[indexPath.row]
        cell.configure(with: item)
    }

}

// MARK: - Outputs to view
extension DefaultHeroesListPresenter: HeroesListInteractorOutput {
    
    func showError(_ message: String?, title: String?) {
        
        view?.endRefreshingView()
        router.showAlert(msg: message ?? "An error has ocurred",
                         title: title ?? "Oops!")
    }
    
    func updateView(list: [CharacterListEntity]) {
        
        self.heroesList = list
        view?.refreshView()
    }

}
