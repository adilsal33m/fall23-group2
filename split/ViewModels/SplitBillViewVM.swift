//
//  SplitBillViewVM.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class SplitBillViewVM: ObservableObject{
    
    let db = Firestore.firestore()
    
    func createExpenseEntry(){
        let friend1 = Friends(id: "12341", amount: 1200)
        let friend2 = Friends(id: "12342", amount: 1400)
        
        let expense = Expense(id: UUID(), createdBy: "12233", name: "Restuarant", friends: [friend1,friend2])
        
        do {
            _ = try db.collection("Expense").document(expense.id.uuidString).setData(from: expense)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }

        
    }
}
