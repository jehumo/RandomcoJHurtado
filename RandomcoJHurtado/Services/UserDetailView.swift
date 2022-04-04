//
//  UserDetailView.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 29/4/22
//

import SwiftUI
import SDWebImageSwiftUI

struct UserDetailView: View {
    @EnvironmentObject var favorites: Favorites

    @Binding var showingDetail: Bool
    var user: User
    var body: some View {
         VStack(spacing: 15) {
             Text("\(user.name.first) \(user.name.last)")
                  .font(.system(size: 32))
             ZStack(alignment: .bottomTrailing) {
                 WebImage(url: URL(string: user.picture.large))
                     .resizable()
                     .scaledToFill()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: 130, height: 130, alignment: .trailing)
                     .clipShape(Rectangle())
                     .shadow(radius: 40)
                     .overlay(Rectangle().stroke(Color.black, lineWidth: 5))
             }

             Text("Gender: \(String(user.gender.rawValue))")

            Text("\(user.location.street.name) \(user.location.street.number),\(user.location.city).)")
                 .padding()

             Text("Registered since:  \(String((user.registered.date.prefix(10))))")

             HStack(alignment: .center, spacing: 10) {
                 VStack {
                     Text(user.email)
                         .font(.system(size: 14))
                     Text("Phone: \(user.phone)")
                         .font(.system(size: 14))
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

         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .background(Color.blue.opacity(0.3))
    }
}
