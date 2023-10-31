//
//  User.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID
    var email: String
    var name: String
    // Add more properties as needed

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        // Add more cases as needed
    }
}
