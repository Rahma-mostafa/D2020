// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subCategories = try? newJSONDecoder().decode(SubCategories.self, from: jsonData)

import Foundation

// MARK: - SubCategories
struct SubCategories: Codable {
    let status: Bool
    let message: String
    let data: [SubCategoriesData]
}

// MARK: - Datum
struct SubCategoriesData: Codable {
    let id, parent: Int
    let name, arabicName: String
    let datumDescription, arabicDescription: String?
    let image, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, parent, name
        case arabicName = "arabic_name"
        case datumDescription = "description"
        case arabicDescription = "arabic_description"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
