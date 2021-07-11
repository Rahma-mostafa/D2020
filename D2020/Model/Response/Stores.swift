// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let stores = try? newJSONDecoder().decode(Stores.self, from: jsonData)

import Foundation

// MARK: - Stores
struct Stores:Codable {
    let status: Bool?
    let message: String?
    let data: [StoesDataClass]?
}

// MARK: - Datum
struct StoesDataClass:Codable{
    let id: Int?
    let name, code, arabicName: String?
    let datumDescription, arabicDescription: String?
    let address: String?
    let subscriberID, cityID, categoryID, subCategoryID: Int?
    let phone: String?
    let email: String?
    let image: String?
    let video: String?
    let begin, end: String?
    let status: Int?
    let longi, lati: String?
    let best, rating, views: Int?
    let createdAt, updatedAt: String?
    let images: [Image]?
    let products: [Product]?
    let reviews: [StoreReview]?
}

// MARK: - Image
struct Image:Codable {
    let id, stageID: Int?
    let image, createdAt, updatedAt: String?
}

// MARK: - Product
struct Product:Codable {
    let id: Int?
    let name, arabicName, price, productDescription: String?
    let arabicDescription: String?
    let stageID: Int?
    let image, offer, createdAt, updatedAt: String?
}

// MARK: - Review
struct StoreReview:Codable {
    let id, stageID, userID: Int?
    let review: String?
    let rating: Int?
    let username: String?
    let image: String?
    let createdAt, updatedAt: String?
}
