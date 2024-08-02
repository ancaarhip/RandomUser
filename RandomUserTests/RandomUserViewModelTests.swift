//
//  RandomUserViewModelTests.swift
//  RandomUserTests
//
//  Created by Anca Arhip on 31.07.2024.
//

import XCTest
@testable import RandomUser

final class RandomUserViewModelTests: XCTestCase {
    
    var sut: UsersViewModel!

    @MainActor 
    override func setUpWithError() throws {
        sut = UsersViewModel(randomUserAPI: RandomUserAPIMock())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    @MainActor
    func test_givenMockData_WhenFetchIsExecuted_TheViewStateChanges() async throws {
        XCTAssertEqual(sut.viewState, .notLoaded)
        //
        let task = Task { try await sut.testableLoadingData() }
        
        await Task.yield()
        //
        XCTAssertTrue(sut.viewState == .loading, "Loading state should be: loading")
        //
        try await task.value
        //
        XCTAssertTrue(sut.viewState == .loaded, "Loading state should be: loaded")
        
    }
    
    @MainActor
    func test_givenMockData_WhenFetchIsExecuted_DataIsLoaded() async throws {
        //
        let task = Task { try await sut.testableLoadingData() }
        
        await Task.yield()
        //
        try await task.value
        //
        XCTAssertEqual(sut.users.count, 9, "Number of users loaded should be: 9")
        
    }

}
