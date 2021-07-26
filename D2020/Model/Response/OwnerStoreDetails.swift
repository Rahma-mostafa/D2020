// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeDetails = try? newJSONDecoder().decode(StoreDetails.self, from: jsonData)

import Foundation

// MARK: - StoreDetails
struct OwnerStoreDetails: Codable {
    let status: Bool
    let message: String
    let data: OwnerStoreData
}

// MARK: - StoreDetailsData
struct OwnerStoreData: Codable {
    let data: OtherStoreData
    let images, reviews, delegates: [JSONAny]
    let storeReviewsAverage: Int
    let offers: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case data, images, reviews, delegates
        case storeReviewsAverage = "StoreReviewsAverage"
        case offers
    }
}

// MARK: - DataData
struct OtherStoreData: Codable {
    let id: Int
    let image: String
    let rating: Int
    let address, lati, longi: String
    let cityID, categoryID, subscriberID: Int
    let end, name, arabicName: String
    let code: JSONNull?
    let phone, email, dataDescription, arabicDescription: String
    let subCategoryID: Int
    let video, begin: String
    let best: JSONNull?
    let status: String
    let views: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, image, rating, address, lati, longi
        case cityID = "city_id"
        case categoryID = "category_id"
        case subscriberID = "subscriber_id"
        case end, name
        case arabicName = "arabic_name"
        case code, phone, email
        case dataDescription = "description"
        case arabicDescription = "arabic_description"
        case subCategoryID = "sub_category_id"
        case video, begin, best, status, views
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
