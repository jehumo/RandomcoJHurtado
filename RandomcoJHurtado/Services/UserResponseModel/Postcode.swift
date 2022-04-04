import Foundation

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let xValue = try? container.decode(Int.self) {
            self = .integer(xValue)
            return
        }
        if let xValue = try? container.decode(String.self) {
            self = .string(xValue)
            return
        }
    throw DecodingError.typeMismatch(Postcode.self,
                                     DecodingError.Context(codingPath: decoder.codingPath,
                                                           debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let xValue):
            try container.encode(xValue)
        case .string(let xValue):
            try container.encode(xValue)
        }
    }
}
