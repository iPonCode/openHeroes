//  ComicEntity.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

struct ComicEntity {
    let comicId: Int
    let name: String
    var detailURL: URL?
}

extension ComicEntity {
    init(_ dto: ComicsItemDTO) {
        comicId = Int(dto.resourceURI.components(separatedBy: "/").last ?? "0") ?? 0
        name = dto.name
        detailURL = URL(string: dto.resourceURI)
    }
}
