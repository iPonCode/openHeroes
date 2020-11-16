//  HeroesListInteractorTests.swift
//  openHeroesTests
//
//  Created by Simón Aparicio on 13/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import XCTest
@testable import openHeroes

class HeroesListInteractorTests: XCTestCase {

    var subjectUnderTest: HeroesListInteractor!
    let dataManagerMock = DataManagerMock()
    let presenterMock = HeroesListPresenterMock()
    
    override func setUp() {
        super.setUp()
        subjectUnderTest = HeroesListInteractor(dataManager: dataManagerMock)
        subjectUnderTest.presenter = presenterMock
    }

    override func tearDown() {
        dataManagerMock.reset()
        presenterMock.reset()
        super.tearDown()
    }

    func test_givenNoError_whenLoadHeroesList_thenReturnSuccess() {
        
        let exp = expectation(description: "test_givenNoError_whenLoadHeroesList_thenReturnSuccess")
        
        // Given
        let expectedList = self.dataManagerMock.listSuccessResponse.data?.results.compactMap( { CharacterListEntity($0) })
        
        // When
        subjectUnderTest.loadHeroesList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

        // Then
        XCTAssertEqual(self.subjectUnderTest.list, expectedList)
    }

    func test_givenErrorOnLocal_whenLoadHeroesList_thenPresenterShowError() {
        
        let exp = expectation(description: "test_givenErrorOnLocal_whenLoadHeroesList_thenPresenterShowError")
        
        // Given
        dataManagerMock.provokeErrorOnLocal()
        
        // When
        subjectUnderTest.loadHeroesList()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

        // Then
        XCTAssertTrue(self.presenterMock.isShowingError)
    }
    
    func test_givenErrorOnRemote_whenLoadHeroesList_thenPresenterShowError() {
        
        let exp = expectation(description: "test_givenErrorOnRemote_whenLoadHeroesList_thenPresenterShowError")
        
        // Given
        dataManagerMock.provokeErrorOnRemote()
        
        // When
        subjectUnderTest.loadHeroesList()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

        // Then
        XCTAssertTrue(self.presenterMock.isShowingError)
    }
}
