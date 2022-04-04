//
//  OrderedUsersListView.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 29/4/22
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderedUsersListView: View {
    @EnvironmentObject var favorites: Favorites
    @Environment(\.presentationMode) var presentationMode
    @StateObject var userService = UserService()
    @State private var users = [User]()
    @State private var presentErrorAlert = false
    @State private var showingDeleteAlert = false
    @State private var shouldShowUserDetailView = false
    @State private var usersToRetrieve: String = "5"
    @State private var errorUsersAlertMessage: String = "Number of users should be greater than 0"
    @State private var presentInsuficientUsersErrorAlert: Bool = false
    @State private var selectedUser: User?
    @State var filteredUsers = RandomUserViewModel().userViewModelSet
    @State var searchQuery = ""
    @State var sortByNameReversed: Bool = false
    @FocusState private var usersValueFieldIsFocused: Bool

    var body: some View {
        VStack {
            Button(action: {
                Task {
                    do {
                        try await userService.fetchUsers(numUsers: (Int(usersToRetrieve) ?? Int(usersToRetrieve)) ?? 0)
                        users = Array(userService.userViewModel.userViewModelSet)
                        for user in users {
                            print(user.name.first)
                        }
                        for item in userService.userViewModel.userViewModelSet {
                            print(item.email)
                        }
                    } catch {
                        presentErrorAlert = true
                    }
                }
            }, label: {
                HStack {
                    Spacer()
                    TextField("Number", text: $usersToRetrieve, onEditingChanged: { (isChanged) in
                        if !isChanged {
                            if let cashFloatValue = Int(usersToRetrieve) {
                                if cashFloatValue < 1 {
                                    errorUsersAlertMessage = "Amount should be greater than 0 "
                                    presentInsuficientUsersErrorAlert = true
                                } else {
                                    presentInsuficientUsersErrorAlert = false
                                }
                            }
                        }
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .font(.system(size: 12))
                        .focused($usersValueFieldIsFocused)
                        .foregroundColor(.blue)
                        .frame(width: 30)
                        .padding(EdgeInsets(top: 18, leading: 40, bottom: 18, trailing: 8))
                        .multilineTextAlignment( .trailing)
                        .alert("Wrong amount", isPresented: $presentInsuficientUsersErrorAlert, actions: {
                            Button("OK") {
                                usersValueFieldIsFocused = true
                            }
                        }, message: {
                            Text(errorUsersAlertMessage)
                        })
                    Text("Fetch " + usersToRetrieve +  " more users")
                        .padding(.horizontal)
                        .font(.custom("MontserratAlternates-Semibold", size: 15))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .alert("Error", isPresented: $presentErrorAlert, actions: {
                            Button("OK") {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }, message: {
                            Text("Error Ferching users")
                        })
                }
            })
                .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
                .buttonStyle(PrimaryButtonStyle())
            NavigationView {
                VStack {
                    List {
                        ForEach(users, id: \.email) { user in
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
                            .swipeActions(allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    userService.userViewModel.addBannedUser(bannedUser: user)
                                    users = Array(userService.userViewModel.userViewModelSet)
                                } label: {
                                    Label("Ban User", systemImage: "trash.fill")
                                }
                            }
                        }
                        .onDelete { offsets in
                            users.remove(atOffsets: offsets)
                        }
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                if sortByNameReversed {
                                    Button("Name Order: Z-A") {
                                        sortByNameReversed.toggle()
                                        users = users.sorted(by: {
                                            $0.name.first > $1.name.first
                                        })}
                                } else {
                                    Button("Name Order: A-Z") {
                                        sortByNameReversed.toggle()
                                        users = users.sorted(by: {
                                            $0.name.first < $1.name.first
                                        })}
                                }
                            }
                        }
                    }
                    .searchable(text: $searchQuery)
                    .onChange(of: searchQuery) { _ in
                        filterUsers()
                    }
                }
                .navigationBarTitle(
                    Text("\(userService.userViewModel.userViewModelSet.count)," +
                         "\(userService.userViewModel.usersBannedSet.count) banned.")
                    )
                .toolbar {
                    EditButton()
                }
                .task {
                    do {
                        try await userService.fetchUsers(numUsers: Int(usersToRetrieve) ?? 5)
                        users = Array(userService.userViewModel.userViewModelSet)
                        for user in users {
                            print(user.name.first)
                        }
                        for item in userService.userViewModel.userViewModelSet {
                            print(item.email)
                        }
                    } catch {
                        presentErrorAlert = true
                    }
                }
            }
            .sheet(isPresented: $shouldShowUserDetailView) {
                if let user = selectedUser {
                    UserDetailView(showingDetail: $shouldShowUserDetailView, user: user)
                }
            }
        }
    }
    func filterUsers() {
        if searchQuery.isEmpty {
            filteredUsers = userService.userViewModel.userViewModelSet
        } else {
            // Union sets
            filteredUsers = userService.userViewModel.userViewModelSet.filter {
                $0.email
                    .localizedCaseInsensitiveContains(searchQuery)
            }.union(userService.userViewModel.userViewModelSet.filter {
                $0.name.first.localizedCaseInsensitiveContains(searchQuery)
            }).union(userService.userViewModel.userViewModelSet.filter {
                $0.name.last.localizedCaseInsensitiveContains(searchQuery)
            })
            }
        users = Array(filteredUsers)
    }
    func removeRows(at offsets: IndexSet, user: User) {
        users.remove(atOffsets: offsets)
        userService.addBannedUser(user: user)
    }
}

struct OrderedUsersListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderedUsersListView()
    }
}
