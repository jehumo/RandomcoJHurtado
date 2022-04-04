//
//  RandomcoJHurtadoTests.swift
//  RandomcoJHurtadoTests
//
//  Created by Jesús Hurtado on 29/4/22
//

import XCTest
@testable import RandomcoJHurtado

class RandomcoJHurtadoTests: XCTestCase {

    func testViewModelAddFirstMatchesExpectedData() async throws {
        let mockNetworking = MockNetworking()

        let users = try await mockNetworking.loadUsers(numUsers: 2).results

        let viewModel = RandomUserViewModel()
        XCTAssertEqual(viewModel.userViewModelSet.count, 0)
        viewModel.addUser(user: users.first!)
        XCTAssertEqual(viewModel.userViewModelSet.count, 1)
        XCTAssertEqual(viewModel.userViewModelSet.first?.name.first, "Priscilla")
        XCTAssertEqual(viewModel.userViewModelSet.first?.name.last, "Hudson")
        XCTAssertEqual(viewModel.userViewModelSet.first?.email, "priscilla.hudson@example.com")
        XCTAssertEqual(viewModel.userViewModelSet.first?.phone, "00-8440-7963")
        XCTAssertEqual(viewModel.userViewModelSet.first?.cell, "0432-537-618")
        XCTAssertEqual(viewModel.userViewModelSet.first?.nat, "AU")
        XCTAssertEqual(viewModel.userViewModelSet.first?.dob.date, "1967-09-26T16:24:40.142Z")
        XCTAssertEqual(viewModel.userViewModelSet.first?.registered.date, "2014-08-17T05:55:35.023Z")
        XCTAssertEqual(viewModel.userViewModelSet.first?.id.name, "TFN")
        XCTAssertEqual(viewModel.userViewModelSet.first?.login.username, "tinyfish604")
    }

    func testViewModelBannedUserIsAdded() async throws {
        let mockNetworking = MockNetworking()

        let users = try await mockNetworking.loadUsers(numUsers: 1).results

        let viewModel = RandomUserViewModel()
        XCTAssertEqual(viewModel.userViewModelSet.count, 0)
        let userToBeBanned = users.first!
        viewModel.addUser(user: userToBeBanned)
        viewModel.addBannedUser(bannedUser: userToBeBanned)
        XCTAssertTrue(viewModel.usersBannedSet.contains(userToBeBanned))

    }
    func testDontShowDuplicatedUsers()  async throws {
        let mockNetworking = MockNetworking()

        let users = try await mockNetworking.loadUsers(numUsers: 1).results
        let repeatedUser = users.first!
        let viewModel = RandomUserViewModel()

        viewModel.addUser(user: repeatedUser)
        viewModel.addUser(user: repeatedUser)
        viewModel.addUser(user: repeatedUser)
        viewModel.addUser(user: repeatedUser)
        viewModel.addUser(user: repeatedUser)

        XCTAssertEqual(viewModel.userViewModelSet.count, 1)
        XCTAssertTrue(viewModel.userViewModelSet.contains(repeatedUser))
    }
    func testDontShowDuplicatedBannedUsers()  async throws {
        let mockNetworking = MockNetworking()

        let users = try await mockNetworking.loadUsers(numUsers: 1).results
        let repeatedBannedUser = users.first!
        let viewModel = RandomUserViewModel()

        viewModel.addBannedUser(bannedUser: repeatedBannedUser)
        viewModel.addBannedUser(bannedUser: repeatedBannedUser)
        viewModel.addBannedUser(bannedUser: repeatedBannedUser)
        viewModel.addBannedUser(bannedUser: repeatedBannedUser)

        XCTAssertEqual(viewModel.usersBannedSet.count, 1)
        XCTAssertTrue(viewModel.usersBannedSet.contains(repeatedBannedUser))
    }

}
