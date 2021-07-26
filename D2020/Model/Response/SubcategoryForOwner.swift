// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subcategoryForOwner = try? newJSONDecoder().decode(SubcategoryForOwner.self, from: jsonData)

import Foundation

// MARK: - SubcategoryForOwner
struct SubcategoryForOwner: Codable {
    let status: Bool
    let message: String
    let data: [SubcategoryStoreClass]
}

// MARK: - Datum
struct SubcategoryStoreClass: Codable {
    let id: Int
    let arabicName: String
    let name, arabicDescription, datumDescription: JSONNull?
    let parent: Int
    let image: String
    let imageBack: JSONNull?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case arabicName = "arabic_name"
        case name
        case arabicDescription = "arabic_description"
        case datumDescription = "description"
        case parent, image
        case imageBack = "image_back"
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
