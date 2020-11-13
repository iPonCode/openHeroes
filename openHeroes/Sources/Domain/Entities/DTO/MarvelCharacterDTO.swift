//  MarvelCharacterDTO.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

struct MarvelCharacterDTO: Codable {
    let id: Int
    let name, resultDescription: String
    let thumbnail: ThumbnailDTO
    let resourceURI: String
    let comics, series: ComicsDTO
    let stories: StoriesDTO
    let events: ComicsDTO
    let urls: [URLElementDTO]

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

public struct ComicsDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItemDTO]
    let returned: Int
}

public struct ComicsItemDTO: Codable {
    let resourceURI: String
    let name: String
}

public struct StoriesDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItemDTO]
    let returned: Int
}

public struct StoriesItemDTO: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

public struct URLElementDTO: Codable {
    let type: String
    let url: String
}
