// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ownerStore = try? newJSONDecoder().decode(OwnerStores.self, from: jsonData)

import Foundation

// MARK: - OwnerStores
struct OwnerStores: Codable {
    let status: Bool
    let message: String
    let data: OwnerStoreDataClass
}

// MARK: - DataClass
struct OwnerStoreDataClass: Codable {
    let stores: [StoreData]
    let subscriberID: Int

    enum CodingKeys: String, CodingKey {
        case stores
        case subscriberID = "subscriber_id"
    }
}

// MARK: - Store
struct StoreData: Codable {
    let id: Int
    let image: String
    let rating: Int
    let address, lati, longi: String
    let cityID, categoryID, subscriberID: Int
    let end, name, arabicName: String
    let code: JSONNull?
    let phone, email, storeDescription, arabicDescription: String
    let subCategoryID: Int
    let video, begin: String
    let best: JSONNull?
    let status: String
    let views: JSONNull?
    let createdAt, updatedAt: String
    let images: [OwnerStoreImage]

    enum CodingKeys: String, CodingKey {
        case id, image, rating, address, lati, longi
        case cityID = "city_id"
        case categoryID = "category_id"
        case subscriberID = "subscriber_id"
        case end, name
        case arabicName = "arabic_name"
        case code, phone, email
        case storeDescription = "description"
        case arabicDescription = "arabic_description"
        case subCategoryID = "sub_category_id"
        case video, begin, best, status, views
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case images
    }
}

// MARK: - Image
struct OwnerStoreImage: Codable {
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

// MARK: - Encode/decode helpers
//
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
