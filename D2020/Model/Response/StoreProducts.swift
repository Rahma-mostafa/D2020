// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeProducts = try? newJSONDecoder().decode(StoreProducts.self, from: jsonData)

import Foundation

// MARK: - StoreProducts
struct StoreProducts: Codable {
    let status: Bool
    let message: String
    let data: [ProductData]
}

// MARK: - Datum
struct ProductData: Codable {
    let id: Int
    let name, arabicName, price, datumDescription: String
    let arabicDescription: String
    let tags: JSONNull?
    let stageID: Int
    let image, offer, createdAt, updatedAt: String
    let images: [ProductImage]

    enum CodingKeys: String, CodingKey {
        case id, name
        case arabicName = "arabic_name"
        case price
        case datumDescription = "description"
        case arabicDescription = "arabic_description"
        case tags
        case stageID = "stage_id"
        case image, offer
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case images
    }
}

// MARK: - Image
struct ProductImage: Codable {
    let id, productID: Int
    let image, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
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
