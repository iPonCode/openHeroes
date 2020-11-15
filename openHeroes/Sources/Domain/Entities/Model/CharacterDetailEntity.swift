//  CharacterListEntity.swift
//  openHeroes
//
//  Created by Simón Aparicio on 13/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation

struct CharacterDetailEntity: Equatable {
    let id: Int
    let name: String?
    let comics: [ComicEntity]
    var imageURL: String?
    var description: String?
    var seriesCount: Int = 0
    var storiesCount: Int = 0
    var eventsCount: Int = 0

    static func == (lhs: CharacterDetailEntity, rhs: CharacterDetailEntity) -> Bool {
        return lhs.id == rhs.id
    }
}

extension CharacterDetailEntity {
    init(_ dto: MarvelCharacterDetailDTO) {
        id = dto.id
        name = dto.name
        let path = dto.thumbnail.path
        let fileExtension = dto.thumbnail.thumbnailExtension
        imageURL = "\(path).\(fileExtension)"
        comics = dto.comics.items.compactMap({ ComicEntity($0)})
    }
}
