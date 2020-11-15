//  HeroDetailPresenterMock.swift
//  openHeroesTests
//
//  Created by Simón Aparicio on 15/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation
@testable import openHeroes

class HeroDetailPresenterMock: HeroDetailInteractorOutput {

    func updateView() {
    }
    
    func showError(_ message: String?, title: String?) {
    }
    
    func reset() {
    }
}
