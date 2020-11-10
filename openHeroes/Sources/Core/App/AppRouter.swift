//  AppRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

class AppRouter {
    
    let window: UIWindow
    
    lazy var appConfiguration = AppConfiguration()

    init(window: UIWindow) {
        self.window = window
    }

    func installViewIntoRootViewController() {

        // TODO create repository with appConfiguration
        
        let viewController = DefaultHeroesListRouter.createModule()
        let nav = UINavigationController(rootViewController: viewController)
        window.rootViewController = nav
    }
    
}
