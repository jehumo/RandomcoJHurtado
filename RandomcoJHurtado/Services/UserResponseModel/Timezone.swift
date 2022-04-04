
import Foundation

// MARK: - Timezone
struct Timezone: Codable {
    let offset, timezoneDescription: String

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}
