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
    var data: LoginDataClass
}

// MARK: - DataClass
struct LoginDataClass: Codable {
    let id: Int?
    var name, email, mobile: String?
    var address: String?
    var birthDate, photo: String?
    var token, typ: String?
    var profileLink: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile, address
        case birthDate = "birth_date"
        case photo, token, typ
        case profileLink = "profile_link"
    }
}
