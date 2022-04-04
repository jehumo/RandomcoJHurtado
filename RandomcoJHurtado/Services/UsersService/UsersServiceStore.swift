//
//  UsersServiceStore.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 29/4/22
//

import Foundation

private actor UserServiceStore {
    var networking: NetworkingUserServiceRepository
    init(networking: NetworkingUserServiceRepository) {
        self.networking = networking
    }
}

enum ServerError: Error {
    case urlNotOk
    case statusNotOk
    case decoderError
}

class UserService: ObservableObject {
    @Published private(set) var userViewModel = RandomUserViewModel()
    @Published private(set) var userResponse: UsersResponse?
    @Published private(set) var isFetching = false
    private var store: UserServiceStore
    private var networking: NetworkingUserServiceRepository
    public init(networking: NetworkingUserServiceRepository = RealNetworking()) {
        self.networking = networking
        store = UserServiceStore(networking: networking)
    }
}

extension UserService {
    @MainActor
    func fetchUsers(numUsers: Int ) async throws {
        isFetching = true
        defer {isFetching = false }
        do {
            let userResponse = try await store.networking.loadUsers(numUsers: numUsers).results.sorted()
            for user in userResponse {
                print(user.name.first)
                print(user.picture.thumbnail)
                userViewModel.addUser(user: user)
            }
        } catch {
            throw ServerError.decoderError
        }
    }
    @MainActor
    func addBannedUser(user: User) {
        userViewModel.addBannedUser(bannedUser: user)
    }
}
