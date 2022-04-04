import Foundation

enum Gender: String, Codable, Equatable, Comparable {
    case female
    case male
    static func < (lhs: Gender, rhs: Gender) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
