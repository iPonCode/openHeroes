//  AppRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  
//

import UIKit

class AppRouter {
    
    let window: UIWindow
    
    // TODO AppConfiguration
    
    init(window: UIWindow) {
        self.window = window
    }

    func installViewIntoRootViewController() {

        // TODO CreateRepository
        let listPost = DefaultHeroesListRouter.createModule()
        let nav = UINavigationController(rootViewController: listPost)
        window.rootViewController = nav
    }
    
}
