import Foundation

// MARK: - Result
struct User: Codable, Equatable, Hashable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.name <= rhs.name
    }
    let email: String

    let gender: Gender
    let name: Name
    let location: Location
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
}
