//
//  ExpenseModel.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation

struct Expense: Codable {
    var createdBy: String
    var name: String
    var totalBill:Int
    var friends: [Friends]
    // Add more properties as needed

    enum CodingKeys: String, CodingKey {
        case createdBy
        case name
        case totalBill
        case friends
        // Add more cases as needed
    }
}

