// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storesCities = try? newJSONDecoder().decode(StoresCities.self, from: jsonData)

import Foundation

// MARK: - StoresCities
struct StoresCities: Codable {
    let status: Bool?
    let message: String?
    let data: [CityData]?
}

// MARK: - CityData
struct CityData: Codable {
    let name: String?
    let id: Int?
    let imageBack: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case name, id
        case imageBack = "image_back"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum AtedAt: String, Codable {
    case the20210701194802 = "2021-07-01 19:48:02"
    case the20210724155925 = "2021-07-24 15:59:25"
    case the20210724160002 = "2021-07-24 16:00:02"
    case the20210726053346 = "2021-07-26 05:33:46"
    case the20210729095959 = "2021-07-29 09:59:59"
    case the20210730082301 = "2021-07-30 08:23:01"
}

enum ImageBack: String, Codable {
    case sa062Dk20121920X108011JPEG = "sa-062-dk-2012-1920x10801-1.jpeg"
    case the16275527999448400113A13B2B93B9352F64Fbf70Fd185E9FeJPEG = "16275527999448400113a13b2b93b9352f64fbf70fd185e9fe.jpeg"
    case the1627633381E7E2223Eea1E83E376C04526Bfdcf29F8Eb88466Jpg = "1627633381e7e2223eea1e83e376c04526bfdcf29f8eb88466.jpg"
}
