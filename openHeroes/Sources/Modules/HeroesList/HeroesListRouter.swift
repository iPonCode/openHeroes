//  HeroesListRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

// MARK: Router Input (Presenter -> Router)
protocol HeroesListRouter: class {
    
        func pushToHeroDetail(on view: HeroesListView, with id: Int)
}

class DefaultHeroesListRouter: HeroesListRouter {

    static func createModule(dataManager: MarvelDataManager) -> UIViewController {
        
        let view = HeroesListViewController()
        
        let presenter:  HeroesListPresenter &
                        HeroesListInteractorOutput = DefaultHeroesListPresenter()
        
        view.presenter = presenter
        view.presenter?.router = DefaultHeroesListRouter()
        view.presenter?.view = view
        view.presenter?.interactor = HeroesListInteractor(dataManager: dataManager)
        view.presenter?.interactor?.presenter = presenter
        
        return view
    }
    
    func pushToHeroDetail(on view: HeroesListView, with id: Int) {

        // TODO: HeroDetail Module
        
    }
    
}
