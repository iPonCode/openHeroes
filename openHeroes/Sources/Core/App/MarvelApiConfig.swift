//  MarvelApiConfig.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

final class DefaultMarvelApiConfig: ApiConfiguration {
    
    private lazy var apiBaseURL: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL not found")
        }
        return url
    }()

    private lazy var apiPublicKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "ApiPublicKey") as? String else {
            fatalError("ApiPublicKey not found")
        }
        return key
    }()

    private lazy var apiPrivateKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "ApiPrivateKey") as? String else {
            fatalError("ApiPrivateKey not found")
        }
        return key
    }()
    
    
    // MARK: Methods to obtain the urls
    func getCharactersListUrl() -> String {
        let timeStamp = getTimeStamp()
        return apiBaseURL + "?ts=" + timeStamp + "&apikey=" + apiPublicKey + "&hash=" + getHashCecksum(ts: timeStamp)
    }
    
    func getDetailsUrl(_ id: Int) -> String {
        let timeStamp = getTimeStamp()
        return apiBaseURL + "/" + String(id) + "?ts=" + timeStamp + "&apikey=" + apiPublicKey + "&hash=" + getHashCecksum(ts: timeStamp)
    }

    func getComicsItemUrl(_ resourceURI: String) -> String {
        let timeStamp = getTimeStamp()
        return resourceURI + "?ts=" + timeStamp + "&apikey=" + apiPublicKey + "&hash=" + getHashCecksum(ts: timeStamp)
    }
    
    // MARK: Hash methods
    private func getHashCecksum(ts: String) -> String {
        return String(format: "%@%@%@", ts, apiPrivateKey, apiPublicKey).md5()
    }
    
    private func getTimeStamp() -> String {
        return String(format:"%.f", Date().timeIntervalSince1970)
    }
    
}
