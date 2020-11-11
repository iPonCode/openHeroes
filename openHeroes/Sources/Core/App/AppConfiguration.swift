//  AppConfiguration.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

final class AppConfiguration {
    
    lazy var apiBaseURL: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL not found")
        }
        return url
    }()

    lazy var apiPublicKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "ApiPublicKey") as? String else {
            fatalError("ApiPublicKey not found")
        }
        return key
    }()

    lazy var apiPrivateKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "ApiPrivateKey") as? String else {
            fatalError("ApiPrivateKey not found")
        }
        return key
    }()
    
}
