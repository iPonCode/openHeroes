//  ApiConfiguration.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

protocol ApiConfiguration {
    func getCharactersListUrl() -> String
    func getDetailsUrl(_ id: Int) -> String
}
