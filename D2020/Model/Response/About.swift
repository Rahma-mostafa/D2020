// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let about = try? newJSONDecoder().decode(About.self, from: jsonData)

import Foundation

// MARK: - About
struct About: Codable {
    let status: Bool
    let message: String
    let data: AboutDataClass
}

// MARK: - DataClass
struct AboutDataClass: Codable {
    let content: String
}
