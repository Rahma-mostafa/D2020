// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let updatePassword = try? newJSONDecoder().decode(UpdatePassword.self, from: jsonData)

import Foundation

// MARK: - UpdatePassword
struct UpdatePassword: Codable {
    let status: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int
    let name, email, mobile: String
    let subscriberID, phone, idNumber, cityID: JSONNull?
    let address: String
    let nationality: JSONNull?
    let photo: String
    let birthDate, lastLogin: JSONNull?
    let status, type: String
    let longi, lati, emailVerifiedAt, randomPassword: JSONNull?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile
        case subscriberID = "subscriber_id"
        case phone
        case idNumber = "id_number"
        case cityID = "city_id"
        case address, nationality, photo
        case birthDate = "birth_date"
        case lastLogin = "last_login"
        case status, type, longi, lati
        case emailVerifiedAt = "email_verified_at"
        case randomPassword = "random_password"
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
