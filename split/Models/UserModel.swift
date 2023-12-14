//
//  User.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    var id: UUID
    var email: String
    var name: String
    var OwesYou: [String]?
    var youOwe: [String]?
    
    // Add more properties as needed

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case OwesYou
        case youOwe
        // Add more cases as needed
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id
        }
}


// the logged in user sents a bill to all his friends - the bill goes to the settleUp array in (expense)
