//  MarvelNetworkResponseDTO.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

// List
public struct MarvelListNetworkResponseDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: MarvelListResponseDataDTO?
    
    private enum CodingKeys: String, CodingKey {
        case code, status, copyright, attributionText, attributionHTML, etag, data
    }
}

public struct MarvelListResponseDataDTO: Codable {
    let offset, limit, total, count: Int
    let results: [MarvelCharacterListItemDTO]
}

// Detail
public struct MarvelDetailNetworkResponseDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: MarvelDetailResponseDataDTO?
    
    private enum CodingKeys: String, CodingKey {
        case code, status, copyright, attributionText, attributionHTML, etag, data
    }
}

public struct MarvelDetailResponseDataDTO: Codable {
    let offset, limit, total, count: Int
    let results: [MarvelCharacterDetailDTO] 
}
