//  AppRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

class AppRouter {
    
    let window: UIWindow
    let dataManager: MarvelDataManager
    
    init(window: UIWindow, dataManager: MarvelDataManager) {
        self.window = window
        self.dataManager = dataManager
    }

    func installViewIntoRootViewController() {

        let viewController = DefaultHeroesListRouter.createModule(dataManager: dataManager)
        let nav = UINavigationController(rootViewController: viewController)
        window.rootViewController = nav
    }
    
    
}
