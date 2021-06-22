//
//  LoginResponse.swift
//  D2020
//
//  Created by Mohamed Eltaweel on 22/06/2021.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let status: Bool
    let message: String
    let data: LoginDataClass
}

// MARK: - DataClass
struct LoginDataClass: Codable {
    let id: Int?
    let name, email, mobile, status: String?
    let address: String?
    let birthDate, photo: String?
    let token, typ: String?
    let profileLink: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile, status, address
        case birthDate = "birth_date"
        case photo, token, typ
        case profileLink = "profile_link"
    }
}
