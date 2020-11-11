//  CharacterEntity.swift
//  openHeroes
//
//  Created by Simón Aparicio on 11/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation


struct CharacterEntity {
    let id: Int
    let name: String?
    let comics: [ComicEntity]
    var imageURL: String?
    var description: String?
    var seriesCount: Int = 0
    var storiesCount: Int = 0
    var eventsCount: Int = 0
}

extension CharacterEntity {
    init(_ dto: MarvelCharacterListItemDTO) {
        id = dto.id
        name = dto.name
        if let path = dto.thumbnail?.path, let fileExtension = dto.thumbnail?.thumbnailExtension {
            imageURL = "\(path).\(fileExtension)"
        }
        comics = dto.comics.items.compactMap({ ComicEntity($0)})
    }
}
