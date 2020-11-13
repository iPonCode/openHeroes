//  MarvelCharacterListItemDTO.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

public struct MarvelCharacterListItemDTO: Codable {
    let id: Int
    let name: String?
    let resultDescription: String?
    let thumbnail: ThumbnailDTO?
    let events, series: AvailableItemDTO?
    let comics: ComicsDTO

    enum CodingKeys: String, CodingKey {
        case id, name, thumbnail, series, events, comics
        case resultDescription = "description"
    }
}

public struct ThumbnailDTO: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

public struct AvailableItemDTO: Codable {
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "available"
    }
}
