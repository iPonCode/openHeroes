//  HeroDetailInteractorTests.swift
//  openHeroesTests
//
//  Created by Simón Aparicio on 13/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import XCTest
@testable import openHeroes

class HeroDetailInteractorTests: XCTestCase {

    var subjectUnderTest: HeroDetailInteractor!
    let dataManagerMock = DataManagerMock()
    let presenterMock = HeroDetailPresenterMock()
    
    override func setUp() {
        super.setUp()
        subjectUnderTest = HeroDetailInteractor(dataManager: dataManagerMock, id: 42)
        subjectUnderTest.presenter = presenterMock
    }

    override func tearDown() {
        dataManagerMock.reset()
        presenterMock.reset()
        super.tearDown()
    }

    func test_givenNoError_whenLoadHeroDetail_thenReturnSuccess() {
        
        let exp = expectation(description: "test_givenNoError_whenLoadHeroDetail_thenReturnSuccess")
        
        // Given
        let expectedDetail = self.dataManagerMock.detailSuccessResponse.data?.results.compactMap( { CharacterDetailEntity($0) })
        
        // When
        subjectUnderTest.loadHeroDetail()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

        // Then
        XCTAssertEqual(self.subjectUnderTest.detail, expectedDetail)
    }

    func test_givenErrorOnLocal_whenLoadHeroDetail_thenPresenterShowError() {
        
        let exp = expectation(description: "test_givenErrorOnLocal_whenLoadHeroDetail_thenPresenterShowError")
        
        // Given
        dataManagerMock.provokeErrorOnLocal()
        
        // When
        subjectUnderTest.loadHeroDetail()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

        // Then
        XCTAssertTrue(self.presenterMock.isShowingError)
    }
    
    func test_givenErrorOnRemote_whenLoadHeroDetail_thenPresenterShowError() {
        
        let exp = expectation(description: "test_givenErrorOnRemote_whenLoadHeroDetail_thenPresenterShowError")
        
        // Given
        dataManagerMock.provokeErrorOnRemote()
        
        // When
        subjectUnderTest.loadHeroDetail()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

        // Then
        XCTAssertTrue(self.presenterMock.isShowingError)
    }
    

}
