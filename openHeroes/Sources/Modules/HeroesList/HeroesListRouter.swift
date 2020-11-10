//  HeroesListRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

// MARK: Router Input (Presenter -> Router)
protocol HeroesListRouter: class {
    
    static func createModule() -> UIViewController
    func pushToHeroDetail(on view: HeroesListView, with id: Int)
}

class DefaultHeroesListRouter: HeroesListRouter {

    static func createModule() -> UIViewController {
        
        let viewController = HeroesListViewController()
        
        let presenter:  HeroesListPresenter &
                        HeroesListInteractorOutput = DefaultHeroesListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DefaultHeroesListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HeroesListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushToHeroDetail(on view: HeroesListView, with id: Int) {

        // TODO: HeroDetail Module
        
    }
    
}
