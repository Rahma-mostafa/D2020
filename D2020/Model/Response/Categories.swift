// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let status: Bool
    let message: String
    let data: [categoriesDataClass]
}

// MARK: - Datum
struct categoriesDataClass: Codable {
    let id: Int
    let parent: JSONNull?
    let name, arabicName, datumDescription, arabicDescription: String
    let image, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, parent, name
        case arabicName = "arabic_name"
        case datumDescription = "description"
        case arabicDescription = "arabic_description"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
