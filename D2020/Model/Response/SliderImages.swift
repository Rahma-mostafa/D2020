// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sliderImages = try? newJSONDecoder().decode(SliderImages.self, from: jsonData)

import Foundation

// MARK: - SliderImages
struct SliderImages: Codable {
    let status: Bool?
    let message: String?
    let data: [SliderImagesData]?
}

// MARK: - SliderImagesData
struct SliderImagesData: Codable {
    let id: Int?
    let image, type, createdAt, updatedAt: String?
    enum CodingKeys: String, CodingKey {
        case id, image, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
