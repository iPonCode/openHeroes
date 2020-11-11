//  MarvelNetworkResponseDTO.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

public struct MarvelNetworkResponseDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: MarvelResponseDataDTO?
    
    private enum CodingKeys: String, CodingKey {
        case code, status, copyright, attributionText, attributionHTML, etag, data
    }
}

public struct MarvelResponseDataDTO: Codable {
    let offset, limit, total, count: Int
    let results: [MarvelCharacterListItemDTO]
}
