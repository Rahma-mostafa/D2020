// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let splash = try? newJSONDecoder().decode(Splash.self, from: jsonData)

import Foundation

// MARK: - Splash
struct Splash: Codable {
    let status: Bool
    let message: String
    let data: [SplashData]
}

// MARK: - Datum
struct SplashData: Codable {
    let id: Int
    let image, type, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, image, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
