//  HeroesListRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

// MARK: Router Input (Presenter -> Router)
protocol HeroesListRouter: Alertable {
    func showHeroDetail(_ hero: CharacterListEntity)
}

class DefaultHeroesListRouter: HeroesListRouter {

    var view: UIViewController?
    var dataManager: MarvelDataManager?
    
    static func createModule(dataManager: MarvelDataManager) -> UIViewController {

        let router = DefaultHeroesListRouter()
        let view = HeroesListViewController()
        let interactor = HeroesListInteractor(dataManager: dataManager)
        let presenter = DefaultHeroesListPresenter(interface: view,
                                                   interactor: interactor,
                                                   router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        router.dataManager = dataManager
        
        return view
    }
    
    func showHeroDetail(_ hero: CharacterListEntity) {

        guard let dataManager = dataManager else { return }
        let detailView = DefaultHeroDetailRouter.createModule(with: hero.id, dataManager: dataManager)
        view?.navigationController?.pushViewController((detailView), animated: true)
    }
    
}

