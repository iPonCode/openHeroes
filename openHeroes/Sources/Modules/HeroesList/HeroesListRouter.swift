//  HeroesListRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

// MARK: Router Input (Presenter -> Router)
protocol HeroesListRouter: class {
    
    static func createModule() -> UINavigationController
    func pushToHeroDetail(on view: HeroesListView, with id: Int)
}

class DefaultHeroesListRouter: HeroesListRouter {

    static func createModule() -> UINavigationController {
        
        let viewController = HeroesListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter:  HeroesListPresenter &
                        HeroesListInteractorOutput = DefaultHeroesListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DefaultHeroesListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HeroesListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    func pushToHeroDetail(on view: HeroesListView, with id: Int) {

        // TODO: HeroDetail Module
        
    }
    
}
