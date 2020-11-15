//  DataManagerMock.swift
//  openHeroesTests
//
//  Created by Simón Aparicio on 15/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import Foundation
@testable import openHeroes

class DataManagerMock: MarvelDataManager {
    
    // List
    lazy var characterListItemDTO: MarvelCharacterListItemDTO = {
        MarvelCharacterListItemDTO(id: 1,
                                   name: "test-name",
                                   resultDescription: "",
                                   thumbnail: ThumbnailDTO(path: "", thumbnailExtension: ""),
                                   events: AvailableItemDTO(count: 1),
                                   series: AvailableItemDTO(count: 1),
                                   comics: ComicsDTO(available: 1, collectionURI: "",
                                                     items: [ComicsItemDTO(resourceURI: "http://example.com",
                                                                           name: "Example")], returned: 1))
    }()

    lazy var listResponseData: MarvelListResponseDataDTO = {
        MarvelListResponseDataDTO(offset: 0, limit: 1, total: 1, count: 1, results: [characterListItemDTO])
    }()

    lazy var listSuccessResponse: MarvelListNetworkResponseDTO = {
        let errorResponse = MarvelListNetworkResponseDTO(code: 200,
                                                         status: "",
                                                         copyright: "",
                                                         attributionText: "",
                                                         attributionHTML: "",
                                                         etag: "",
                                                         data: listResponseData)
        return errorResponse
    }()

    lazy var listErrorResponse: MarvelListNetworkResponseDTO = {
        let errorResponse = MarvelListNetworkResponseDTO(code: 404,
                                                         status: "",
                                                         copyright: "",
                                                         attributionText: "",
                                                         attributionHTML: "",
                                                         etag: "",
                                                         data: listResponseData)
        return errorResponse
    }()

    // Detail
    lazy var characterDetailDTO: MarvelCharacterDetailDTO = {
        MarvelCharacterDetailDTO(id: 1,
                                 name: "test",
                                 resultDescription: "test_description",
                                 thumbnail: ThumbnailDTO(path: "",thumbnailExtension: ""),
                                 resourceURI: "http://example.com",
                                 comics: ComicsDTO(available: 1, collectionURI: "",
                                                   items: [ComicsItemDTO(resourceURI: "http://example.com",
                                                                         name: "Example")], returned: 1),
                                 series: ComicsDTO(available: 1, collectionURI: "",
                                                   items: [ComicsItemDTO(resourceURI: "http://example.com",
                                                                         name: "Example")], returned: 1),
                                 stories: StoriesDTO(available: 1, collectionURI: "",
                                                     items: [StoriesItemDTO(resourceURI: "",
                                                                            name: "", type: "")], returned: 1),
                                 events: ComicsDTO(available: 1, collectionURI: "",
                                                   items: [ComicsItemDTO(resourceURI: "http://example.com",
                                                                         name: "Example")], returned: 1),
                                 urls: [URLElementDTO(type: "", url: "")])
    }()

    lazy var detailResponseData: MarvelDetailResponseDataDTO = {
        MarvelDetailResponseDataDTO(offset: 0, limit: 1, total: 1, count: 1, results: [characterDetailDTO])
    }()

    lazy var detailSuccessResponse: MarvelDetailNetworkResponseDTO = {
        let errorResponse = MarvelDetailNetworkResponseDTO(code: 200,
                                                            status: "",
                                                            copyright: "",
                                                            attributionText: "",
                                                            attributionHTML: "",
                                                            etag: "",
                                                            data: detailResponseData)
        return errorResponse
    }()

    lazy var detailErrorResponse: MarvelDetailNetworkResponseDTO = {
        let errorResponse = MarvelDetailNetworkResponseDTO(code: 404,
                                                           status: "",
                                                           copyright: "",
                                                           attributionText: "",
                                                           attributionHTML: "",
                                                           etag: "",
                                                           data: detailResponseData)
        return errorResponse
    }()
    
    private var forceError: Bool = false
    private var forceCustomError: Bool = false
    
    func reset() {
        forceError = false
        forceCustomError = false
    }

    func provokeError() {
        forceError = true
    }

    func provokeCustomError() {
        forceCustomError = true
    }
    
    func loadHeroesList(completion complete: @escaping (MarvelListDataManagerResult) -> Void) {
        complete(forceError ?
                    .failure(MarvelDataManagerError.loadError("ErrorDescriptionForLoadError" as! Error)) :
                    .success(forceCustomError ? listErrorResponse : listSuccessResponse))
    }
    
    func loadHeroDetail(id: Int, completion complete: @escaping (MarvelDetailDataManagerResult) -> Void) {
        complete(forceError ?
                    .failure(MarvelDataManagerError.loadError("ErrorDescriptionForLoadError" as! Error)) :
                    .success(forceCustomError ? detailErrorResponse : detailSuccessResponse))
    }
    
}
