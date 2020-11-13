//  HeroDetailRouter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 13/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

// MARK: Router Input (Presenter -> Router)
protocol HeroDetailRouter: Alertable { }

class DefaultHeroDetailRouter: HeroDetailRouter {

    var view: UIViewController?
    var dataManager: MarvelDataManager?
    
    static func createModule(with id: Int, dataManager: MarvelDataManager) -> UIViewController {

        let router = DefaultHeroDetailRouter()
        let view = HeroDetailViewController()
        let interactor = HeroDetailInteractor(dataManager: dataManager, id: id)
        let presenter = DefaultHeroDetailPresenter(interface: view,
                                                   interactor: interactor,
                                                   router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        router.dataManager = dataManager
        
        return view
    }
        
}

