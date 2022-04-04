//
//  FavoritesTests.swift
//  RandomcoJHurtadoTests
//
//  Created by Jesús Hurtado on 29/4/22
//

import XCTest
@testable import RandomcoJHurtado

class FavoritesTests: XCTestCase {

    func testFavoriteUserIsAdded() async throws {
        let mockNetworking = MockNetworking()
        let users = try await mockNetworking.loadUsers(numUsers: 1).results

        let favorites = Favorites()
        XCTAssertEqual(favorites.getFavorites().count, 0)
        let userToBeFavorite = users.first!
        favorites.add(userToBeFavorite)
        XCTAssertTrue(favorites.contains(userToBeFavorite))
        XCTAssertEqual(favorites.getFavorites().count, 1)
    }

    func testFavoriteUserIsAddedAndRemovedEmpty() async throws {
        let mockNetworking = MockNetworking()
        let users = try await mockNetworking.loadUsers(numUsers: 1).results

        let favorites = Favorites()
        XCTAssertEqual(favorites.getFavorites().count, 0)
        let userToBeFavorite = users.first!
        favorites.add(userToBeFavorite)
        XCTAssertTrue(favorites.contains(userToBeFavorite))
        XCTAssertEqual(favorites.getFavorites().count, 1)
        favorites.remove(userToBeFavorite)
        XCTAssertFalse(favorites.contains(userToBeFavorite))
        XCTAssertEqual(favorites.getFavorites().count, 0)
    }
}
