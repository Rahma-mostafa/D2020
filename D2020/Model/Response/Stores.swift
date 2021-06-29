// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let stores = try? newJSONDecoder().decode(Stores.self, from: jsonData)

import Foundation

// MARK: - Stores
struct Stores: Codable {
    let status: Bool
    let message: String
    let data: [StoesDataClass]
}

// MARK: - Datum
struct StoesDataClass: Codable {
    let id: Int
    let name, code, arabicName, datumDescription: String
    let arabicDescription: String
    let tags: JSONNull?
    let address: String
    let subscriberID, cityID, categoryID, subCategoryID: Int
    let phone, email: String?
    let image: String
    let begin, end, longi, lati: String?
    let status: Int
    let createdAt, updatedAt: String
    let images: [Image]
    let products: [Product]

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
        case images, products
    }
}

// MARK: - Image
struct Image: Codable {
    let id, stageID: Int
    let image, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case stageID = "stage_id"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let name, arabicName, price: String
    let address: JSONNull?
    let productDescription, arabicDescription: String
    let tags: JSONNull?
    let stageID: Int
    let image, offer, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case arabicName = "arabic_name"
        case price, address
        case productDescription = "description"
        case arabicDescription = "arabic_description"
        case tags
        case stageID = "stage_id"
        case image, offer
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
