//
//  RandomcoJHurtadoApp.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 29/4/22.
//

import SwiftUI

@main
struct RandomcoJHurtadoApp: App {
    @StateObject var favorites = Favorites()

    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(favorites)
        }
    }
}
