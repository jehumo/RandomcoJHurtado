//
//  RestNetworking.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 29/4/22
//

import Foundation

extension String {
    func stringByAddingPercentEncodingForRFC3986() -> String? {
        let unreserved = ":-._~/?="
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}

class RealNetworking: NetworkingUserServiceRepository {
    func loadUsers(numUsers: Int) async throws -> UsersResponse {
        let urlUsersString = "https://api.randomuser.me/?results=\(numUsers)".stringByAddingPercentEncodingForRFC3986()
        guard let urlUsersString = urlUsersString,
            let usersURL = URL(string: urlUsersString) else {
            throw ServerError.urlNotOk
        }
        var request = URLRequest(url: usersURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw ServerError.statusNotOk
        }
        guard let userResponseModel = try? JSONDecoder().decode(UsersResponse.self, from: data) else {
            throw ServerError.decoderError
        }
        return userResponseModel
    }
}
