import Foundation

// MARK: - Name
struct Name: Codable, Equatable, Comparable {
    let title: Title
    let first, last: String
    static func == (lhs: Name, rhs: Name) -> Bool {
        return lhs.first == rhs.first
    }
    static func < (lhs: Name, rhs: Name) -> Bool {
        return lhs.first < rhs.first
    }
}
