// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let citiesForOwner = try? newJSONDecoder().decode(CitiesForOwner.self, from: jsonData)

import Foundation

// MARK: - CitiesForOwner
struct CitiesForOwner: Codable {
    let status: Bool
    let message: String
    let data: [CitiesData]
}

// MARK: - Datum
struct CitiesData: Codable {
    let name: String
    let id: Int
    let imageBack: ImageBack
    let createdAt: CreatedAt
    let updatedAt: UpdatedAt

    enum CodingKeys: String, CodingKey {
        case name, id
        case imageBack = "image_back"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum CreatedAt: String, Codable {
    case the20210701194802 = "2021-07-01 19:48:02"
    case the20210724155925 = "2021-07-24 15:59:25"
}

enum ImageBack: String, Codable {
    case sa062Dk20121920X108011JPEG = "sa-062-dk-2012-1920x10801-1.jpeg"
}

enum UpdatedAt: String, Codable {
    case the20210701194802 = "2021-07-01 19:48:02"
    case the20210724160002 = "2021-07-24 16:00:02"
}
