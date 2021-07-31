// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subCategories = try? newJSONDecoder().decode(SubCategories.self, from: jsonData)

import Foundation

// MARK: - SubCategories
struct SubCategories: Codable {
    let status: Bool?
    let message: String?
    let data: [SubCategoriesData]?
}

// MARK: - Datum
struct SubCategoriesData: Codable {
    let id: Int?
    let arabicName: String?
    let name: String?
    let arabicDescription, datumDescription: String?
    let parent: Int?
    let image: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case arabicName = "arabic_name"
        case name
        case arabicDescription = "arabic_description"
        case datumDescription = "description"
        case parent, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
