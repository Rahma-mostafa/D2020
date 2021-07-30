// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)
//categoriesDataClass

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let status: Bool?
    let message: String?
    let data: [categoriesDataClass]?
}

// MARK: - Datum
struct categoriesDataClass: Codable {
    let id: Int?
    let arabicName: String?
    let name: String?
    let arabicDescription, datumDescription, parent: JSONNull?
    let image: String?
    let imageBack: String?
    let createdAt, updatedAt: CategoriesAtedAt?
    let subCatCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case arabicName = "arabic_name"
        case name
        case arabicDescription = "arabic_description"
        case datumDescription = "description"
        case parent, image
        case imageBack = "image_back"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case subCatCount = "sub_cat_count"
    }
}

enum CategoriesAtedAt: String, Codable {
    case the20210702093616 = "2021-07-02 09:36:16"
    case the20210717101052 = "2021-07-17 10:10:52"
    case the20210717104713 = "2021-07-17 10:47:13"
    case the20210717130446 = "2021-07-17 13:04:46"
    case the20210724095508 = "2021-07-24 09:55:08"
    case the20210724121856 = "2021-07-24 12:18:56"
}
