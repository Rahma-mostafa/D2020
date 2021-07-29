// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ownerMessagesWithUsers = try? newJSONDecoder().decode(OwnerMessagesWithUsers.self, from: jsonData)

import Foundation

// MARK: - OwnerMessagesWithUsers
struct OwnerMessagesWithUsers: Codable {
    let status: Bool?
    let title: String?
    let messages: [MessageDetails]?
    let username: String?
}

// MARK: - Message
struct MessageDetails: Codable {
    let id: Int?
    let subject, message, type: String?
    let file: JSONNull?
    let senderID, userType, receiverID, subscriberID: Int?
    let stageID: Int?
    let chat: String?
    let views: Int?
    let createdAt, updatedAt: String?
    let maxAttempts: Int?

    enum CodingKeys: String, CodingKey {
        case id, subject, message, type, file
        case senderID = "sender_id"
        case userType = "user_type"
        case receiverID = "receiver_id"
        case subscriberID = "subscriber_id"
        case stageID = "stage_id"
        case chat, views
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case maxAttempts = "max_attempts"
    }
}
