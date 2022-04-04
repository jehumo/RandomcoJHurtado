//
//  FavoritesListView.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 29/4/22
//
import SwiftUI
import SDWebImageSwiftUI

struct FavoritesListView: View {

    @EnvironmentObject var favorites: Favorites
    @StateObject var userService = UserService()
    @State private var users = [User]()
    @State private var shouldShowUserDetailView = false
    @State private var selectedUser: User?

    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    List {
                        ForEach(favorites.getFavorites(), id: \.email) { user in
                            HStack(alignment: .center, spacing: 10) {

                                ZStack(alignment: .bottomTrailing) {
                                    WebImage(url: URL(string: user.picture.large))
                                        .resizable()
                                        .scaledToFill()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 120, height: 120, alignment: .trailing)
                                        .clipShape(Circle())
                                        .shadow(radius: 10)
                                        .overlay(Circle().stroke(Color.blue, lineWidth: 5))
                                        .onTapGesture {
                                            selectedUser = user
                                            shouldShowUserDetailView = true
                                        }
                                    Text(user.name.first + " " + user.name.last)
                                        .font(.system(size: 8))
                                        .padding(1)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .offset(x: -35, y: -9)
                                }
                                VStack {
                                    Text(user.email)
                                        .font(.system(size: 10))
                                    Text(user.phone)
                                        .font(.system(size: 10))
                                    HStack {

                                        Button(action: {
                                            if favorites.contains(user) {
                                                favorites.remove(user)
                                            } else {
                                                favorites.add(user)
                                            }
                                        }) {
                                            HStack {
                                                if favorites.contains(user) {
                                                    Image(systemName: "heart.slash")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 15, height: 15, alignment: .trailing)
                                                    Text("Remove Favorite")
                                                        .font(.system(size: 10))
                                                } else {
                                                    Image("fav-icon")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 15, height: 15, alignment: .trailing)
                                                    Text("Add to Favorites")
                                                        .font(.system(size: 10))
                                                }
                                            }
                                        }
                                        .padding()
                                        .foregroundColor(.black)
                                        .background(Color.orange)
                                        .cornerRadius(.infinity)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                .navigationBarTitle(Text("\(favorites.getFavorites().count) favorite users"))
            }
            .sheet(isPresented: $shouldShowUserDetailView) {
                if let user = selectedUser {
                    UserDetailView(showingDetail: $shouldShowUserDetailView, user: user)
                }
            }
        }
    }
}
