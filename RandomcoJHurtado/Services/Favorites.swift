//
//  Favorites.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 29/4/22
//

import Foundation
class Favorites: ObservableObject {
    // the actual users the user has favorited
    private var favorites: Set<User>
    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"
    init() {
        // load our saved data
        favorites = []
    }
    // returns true if our set contains this user
    func contains(_ user: User) -> Bool {
        favorites.contains(user)
    }
    // adds the user to our set, updates all views, and saves the change
    func add(_ user: User) {
        objectWillChange.send()
        favorites.insert(user)
        save()
    }
    // removes the user from our set, updates all views, and saves the change
    func remove(_ user: User) {
        objectWillChange.send()
        favorites.remove(user)
        save()
    }
    func getFavorites() -> [User] {
        return Array(favorites)
    }
    func save() {
        // write out our data to userdefaults
    }
}
