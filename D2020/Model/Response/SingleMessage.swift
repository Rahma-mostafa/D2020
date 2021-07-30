// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let SingleMessage = try? newJSONDecoder().decode(SingleMessage.self, from: jsonData)

import Foundation

// MARK: - SingleMessage
struct SingleMessage: Codable {
    let status: Bool?
    let message, user: String?
    let data: [MessagesData]?
}

// MARK: - Datum
struct MessagesData: Codable {
    let status, type, message: String?
    let file: String?
    let date: String?
}
