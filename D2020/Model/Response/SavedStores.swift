// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let savedStores = try? newJSONDecoder().decode(SavedStores.self, from: jsonData)

import Foundation

// MARK: - SavedStores
struct SavedStores: Codable {
    let status: Bool
    let message: String
    let data: [SavedStoresData]
}

// MARK: - Datum
struct SavedStoresData: Codable {
    let id, stageID, userID: Int
    let name, arName: String
    let datumDescription, arDescription: String?
    let image, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case stageID = "stage_id"
        case userID = "user_id"
        case name
        case arName = "ar_name"
        case datumDescription = "description"
        case arDescription = "ar_description"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


