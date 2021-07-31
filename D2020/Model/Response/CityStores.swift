// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cityStores = try? newJSONDecoder().decode(CityStores.self, from: jsonData)

import Foundation

// MARK: - CityStores
struct CityStores: Codable {
    let status: Bool?
    let message: String?
    let data: CityStoresData?
}

// MARK: - DataClass
struct CityStoresData: Codable {
    let currentPage: Int?
    let data: [CityStoresDetails]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let nextPageURL: JSONNull?
    let path: String?
    let perPage: Int?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case to, total
    }
}

// MARK: - Datum
struct CityStoresDetails: Codable {
    let id: Int?
    let image: String?
    let rating: Int?
    let address: String?
    let lati, longi: String?
    let cityID, categoryID, subscriberID: Int?
    let end, name, arabicName: String?
    let code: String?
    let phone, email, datumDescription, arabicDescription: String?
    let subCategoryID: Int?
    let video: String?
    let begin: String?
    let status: String?
    let views: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, image, rating, address, lati, longi
        case cityID = "city_id"
        case categoryID = "category_id"
        case subscriberID = "subscriber_id"
        case end, name
        case arabicName = "arabic_name"
        case code, phone, email
        case datumDescription = "description"
        case arabicDescription = "arabic_description"
        case subCategoryID = "sub_category_id"
        case video, begin, status, views
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

