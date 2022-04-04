import Foundation

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}
