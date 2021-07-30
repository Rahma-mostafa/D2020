// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let singleAdminMessage = try? newJSONDecoder().decode(SingleAdminMessage.self, from: jsonData)

import Foundation

// MARK: - SingleAdminMessage
struct SingleAdminMessage: Codable {
    let status: Bool?
    let title: String?
    let messages: [AdminMessage]?
    let username: String?
}

// MARK: - Message
struct AdminMessage: Codable {
    let status, type, message: String?
    let file: String?
    let date: String?
}
