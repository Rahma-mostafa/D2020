// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subCategoryStores = try? newJSONDecoder().decode(SubCategoryStores.self, from: jsonData)

import Foundation

// MARK: - SubCategoryStores
struct SubCategoryStores: Codable {
    let status: Bool
    let message: String
    let data: [SubCategoryStoresData]
}

// MARK: - Datum
struct SubCategoryStoresData: Codable {
    let id: Int
    let name: String
    let code: String?
    let arabicName, datumDescription, arabicDescription: String
    let tags: JSONNull?
    let address: String
    let subscriberID, cityID, categoryID, subCategoryID: Int
    let phone, email: String?
    let image: String
    let begin, end, longi, lati: String?
    let status: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, code
        case arabicName = "arabic_name"
        case datumDescription = "description"
        case arabicDescription = "arabic_description"
        case tags, address
        case subscriberID = "subscriber_id"
        case cityID = "city_id"
        case categoryID = "category_id"
        case subCategoryID = "sub_category_id"
        case phone, email, image, begin, end, longi, lati, status
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
