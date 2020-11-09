//  HeroesListRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

class HeroesListRouter: PresenterToRouterHeroesListProtocol {

    static func createModule() -> UINavigationController {
        
        let viewController = HeroesListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter:  ViewToPresenterHeroesListProtocol &
                        InteractorToPresenterHeroesListProtocol = HeroesListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = HeroesListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HeroesListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    func pushToHeroDetail(on view: PresenterToViewHeroesListProtocol, with id: Int) {

        // TODO: HeroDetail Module

//        let heroDetailViewController = HeroDetailRouter.createModule(with: id)

//        let viewController = view as! HeroesListViewController
//        viewController.navigationController?
//            .pushViewController(heroDetailViewController, animated: true)
        
    }
    
}
