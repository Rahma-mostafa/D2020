//
//  UpdateProfileResponse.swift
//  D2020
//
//  Created by Mohamed Eltaweel on 13/07/2021.
//

import Foundation

// MARK: - UpdateProfileResponse
struct UpdateProfileResponse: Codable {
    let status: Bool?
    let message: String?
    var data: UpdateProfileData?
}

// MARK: - DataClass
struct UpdateProfileData: Codable {
    let mobile, address: String?
    let id: Int?
    let email: String?
    let photo: String?
    let updatedAt, name: String?

    enum CodingKeys: String, CodingKey {
        case mobile, address, id, email, photo
        case updatedAt = "updated_at"
        case name
    }
}
