//
//  MainView.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 6/4/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Group {
                OrderedUsersListView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.yellow.opacity(0.3))
                    .tabItem {
                        Label("Users", systemImage: "person.fill")
                    }
                FavoritesListView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.yellow.opacity(0.3))
                    .tabItem {
                        Label("Fav Users", systemImage: "heart.circle")
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Favorites())
    }
}
