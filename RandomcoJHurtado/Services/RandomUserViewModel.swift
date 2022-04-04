//
//  RandomUserViewModel.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 29/4/22
//

import Foundation

class RandomUserViewModel: ObservableObject {
    @Published private(set) var userViewModelSet: Set<User> = []
    @Published private(set) var usersBannedSet: Set<User> = []

    func addUser(user: User) {
        userViewModelSet.insert(user)
    }
    func addBannedUser(bannedUser: User) {
        usersBannedSet.insert(bannedUser)
        userViewModelSet = userViewModelSet.subtracting(usersBannedSet)
    }

}
