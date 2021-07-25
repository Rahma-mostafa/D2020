// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ownerStoreDetails = try? newJSONDecoder().decode(OwnerStoreDetails.self, from: jsonData)

import Foundation

// MARK: - OwnerStoreDetails
struct OwnerStoreDetails: Codable {
    let status: Bool
    let message: String
    let data: StoreDataClass
}

// MARK: - StoreDataClass
struct StoreDataClass: Codable {
    let id, subscriberID: Int
    let code: JSONNull?
    let email, phone: String
    let mobile: JSONNull?
    let name: String
    let photo: String
    let cityID: Int
    let address: String
    let status: Int
    let notiCode: JSONNull?
    let type: String
    let longi, lati: JSONNull?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case subscriberID = "subscriber_id"
        case code, email, phone, mobile, name, photo
        case cityID = "city_id"
        case address, status
        case notiCode = "noti_code"
        case type, longi, lati
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
