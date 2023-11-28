//
//  ExpenseModel.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id: UUID
    var createdBy: String
    var name: String
    var friends: [Friends]
    // Add more properties as needed

    enum CodingKeys: String, CodingKey {
        case id
        case createdBy
        case name
        case friends
        // Add more cases as needed
    }
}
