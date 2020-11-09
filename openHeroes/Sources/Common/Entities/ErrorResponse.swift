//  ErrorResponse.swift
//  openHeroes
//
//  Created by Simón Aparicio on 09/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    var code, message: String
}
