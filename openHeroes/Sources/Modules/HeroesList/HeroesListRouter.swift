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
        
        // TODO: Create repository and inject dataManager from AppDelegate
        let appConfiguration = AppConfiguration()
        let url = ApiConfig.getCharactersListUrl(config: appConfiguration)
        let webService = DefaultWebService()
        let service = DefaultMarvelService(webService: webService, loadUrlString: url)
        let dataManager = DefaultMarvelDataManager(service: service)

        viewController.presenter = presenter
        viewController.presenter?.router = DefaultHeroesListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HeroesListInteractor(dataManager: dataManager)
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushToHeroDetail(on view: HeroesListView, with id: Int) {

        // TODO: HeroDetail Module
        
    }
    
}
