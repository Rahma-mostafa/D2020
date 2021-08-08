// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categoriesForOwner = try? newJSONDecoder().decode(CategoriesForOwner.self, from: jsonData)

import Foundation

// MARK: - CategoriesForOwner
struct CategoriesForOwner: Codable {
    let status: Bool?
    let message: String?
    let data: [CategoryDataClass]?
}

// MARK: - Datum
struct CategoryDataClass: Codable {
    let id: Int?
    let arabicName: String?
    let name: String?
    let arabicDescription, datumDescription : String?
    let image: String?
    let imageBack: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case arabicName = "arabic_name"
        case name
        case arabicDescription = "arabic_description"
        case datumDescription = "description"
        case image
        case imageBack = "image_back"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


