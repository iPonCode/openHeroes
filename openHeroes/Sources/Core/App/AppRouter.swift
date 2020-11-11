//  AppRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

class AppRouter {
    
    let window: UIWindow
    
    lazy var apiConfiguration = DefaultMarvelApiConfig()
    
    lazy var dataManager: MarvelDataManager = {
        let webService = DefaultWebService()
        let service = DefaultMarvelService(webService: webService,
                                           loadUrlString: apiConfiguration.getCharactersListUrl())
        return DefaultMarvelDataManager(service: service)
    }()

    init(window: UIWindow) {
        self.window = window
    }

    func installViewIntoRootViewController() {

        let viewController = DefaultHeroesListRouter.createModule(dataManager: dataManager)
        let nav = UINavigationController(rootViewController: viewController)
        window.rootViewController = nav
    }
    
    
}
