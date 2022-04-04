import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let results: [User]
    let info: Info
}
