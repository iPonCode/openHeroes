//  HeroesListContract.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHeroesListProtocol: class {
    
    static func createModule() -> UINavigationController
    
    func pushToHeroDetail(on view: PresenterToViewHeroesListProtocol, with id: Int)
}

// MARK: View Output (Presenter -> View)
protocol PresenterToViewHeroesListProtocol: class {
    func onFetchHeroesListSuccess()
    func onFetchHeroesListFailure(error: String)
    
    func showProgress()
    func hideProgress()
    
    func deselectRowAt(row: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHeroesListProtocol: class {
    
    var view: PresenterToViewHeroesListProtocol? { get set }
    var interactor: PresenterToInteractorHeroesListProtocol? { get set }
    var router: PresenterToRouterHeroesListProtocol? { get set }
    
    var heroesList: [CharacterListItemDTO]? { get set }
    
    func viewDidLoad()
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    func getCellInfo(indexPath: IndexPath) -> CharacterListItemDTO?
    
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)

}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHeroesListProtocol: class {
    
    func fetchHeroesListSuccess(heroes: [CharacterListItemDTO])
    func fetchHeroesListFailure(errorResponse: ErrorResponse)
    
    func getHeroSuccess(_ hero: CharacterListItemDTO)
    func getHeroFailure()
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHeroesListProtocol: class {
    
    var presenter: InteractorToPresenterHeroesListProtocol? { get set }
    
    func loadHeroesList()
    func retrieveHero(at index: Int)
}

