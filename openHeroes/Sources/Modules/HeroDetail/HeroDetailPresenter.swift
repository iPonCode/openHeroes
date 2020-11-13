//  HeroDetailPresenter.swift
//  openHeroes
//
//  Created by Simón Aparicio on 13/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

// MARK: (View -> Presenter)
protocol HeroDetailPresenter {
    func viewDidLoad()
    func configure() -> (String, String) // TODO: Detail UI design
}

class DefaultHeroDetailPresenter {
    
    private weak var view: HeroDetailView?
    var interactor: HeroDetailInteractorInput?
    private let router: HeroDetailRouter
    
    init(interface: HeroDetailView,
         interactor: HeroDetailInteractorInput?,
         router: HeroDetailRouter) {
        
        view = interface
        self.interactor = interactor
        self.router = router
    }
}

extension DefaultHeroDetailPresenter: HeroDetailPresenter {

    func configure() -> (String, String) { // TODO: Detail UI design
        
        guard let detail = interactor?.detail.first else { return ("","") }
        var title = "(\(detail.id) )"
        if let name = detail.name { title = title + name }
        let rawData = String(format: "Name: %@.\n(id: %d)\n\nDescription: %@.\n\nEvents: %d.\nSeries: %d.\nStories: %d.\n\nImage: %@.",
                             detail.name ?? "no name", detail.id, detail.description ?? "no description",
                             detail.eventsCount, detail.seriesCount, detail.storiesCount,
                             detail.imageURL ?? "no image")
        return (title, rawData)
    }

    // MARK: Inputs from view
    func viewDidLoad() {
        guard let interactor = interactor else { return }
        interactor.loadHeroDetail()
    }
}

// MARK: - Outputs to view
extension DefaultHeroDetailPresenter: HeroDetailInteractorOutput {
    
    func showError(_ message: String?, title: String?) {
        
        router.showAlert(msg: message ?? "An error has ocurred",
                         title: title ?? "Oops!")
    }
    
    func updateView() {
        view?.refreshView()
    }

}
