// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let stores = try? newJSONDecoder().decode(Stores.self, from: jsonData)
//
import Foundation

// MARK: - Stores
struct Stores:Codable {
    let status: Bool?
    let message: String?
    let data: StoresDataContainerClass?
}

struct StoresDataContainerClass: Codable{
    var data: [StoesDataClass]?
}

// MARK: - StoesDataClass
struct StoesDataClass: Codable {
    let id: Int?
    let image: String?
    let rating: Int?
    let address, lati, longi: String?
    let cityID, categoryID, subscriberID: Int?
    let end, name, arabicName, code: String?
    let phone: String?
    let email, stoesDataClassDescription, arabicDescription: String?
    let subCategoryID: Int?
//    let video: NSNull?
    let begin: String?
    let best: Int?
    let status: String?
//    let views: NSNull?
    let createdAt, updatedAt: String?
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
