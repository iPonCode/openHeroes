//  ApiConfig.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  
//

import Foundation

// TODO: Create a Repository

struct ApiConfig {

    // MARK: Methods to obtain the urls
    static func getCharactersListUrl(config: AppConfiguration) -> String {
        
        let timeStamp = getTimeStamp()
        return config.apiBaseURL + "?ts=" + timeStamp + "&apikey=" + config.apiPublicKey + "&hash=" + getHashCecksum(ts: timeStamp, config: config)
    }
    
    static func getDetailsUrl(_ id: Int, config: AppConfiguration) -> String {
        let timeStamp = getTimeStamp()
        return config.apiBaseURL + "/" + String(id) + "?ts=" + timeStamp + "&apikey=" + config.apiPublicKey + "&hash=" + getHashCecksum(ts: timeStamp, config: config)
    }

    static func getComicsItemUrl(_ resourceURI: String, config: AppConfiguration) -> String {
        let timeStamp = getTimeStamp()
        return resourceURI + "?ts=" + timeStamp + "&apikey=" + config.apiPublicKey + "&hash=" + getHashCecksum(ts: timeStamp, config: config)
    }
    
    // MARK: Hash methods
    static private func getHashCecksum(ts: String, config: AppConfiguration) -> String {
        return String(format: "%@%@%@", ts, config.apiPrivateKey, config.apiPublicKey).md5()
    }
    
    static private func getTimeStamp() -> String {
        // returns allways a different time stamp
        return String(format:"%.f", Date().timeIntervalSince1970)
    }
    
    // TODO: Declare headers for webservice here if needed
    
    private init() {}
}
