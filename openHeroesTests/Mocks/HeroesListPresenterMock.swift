//  HeroesListPresenterMock.swift
//  openHeroesTests
//
//  Created by Simón Aparicio on 15/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation
@testable import openHeroes

class HeroesListPresenterMock: HeroesListInteractorOutput {
    
    var isShowingError: Bool = false

    func updateView() {
    }
    
    func showError(_ message: String?, title: String?) {
        isShowingError = true
    }
    
    func reset() {
        isShowingError = false
    }
}
