//
//  AddExpenseViewVM.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine
import SwiftData

@Observable
class AddExpenseViewVM: ObservableObject{
    var BillDesc = ""
    var totalString = ""
    var Total = 0.0
    
    var db = Firestore.firestore()
    
    var users:[User] = []
    
    func fetchUsers(){
        db.collection("Users").getDocuments{snapshot, error in
            if let error = error{
                print("Error getting documents \(error)")
            } else{
                self.users = snapshot?.documents.compactMap{ document in
                    try? document.data(as: User.self)
                    
                } ?? []
            }
            
        }
    }
}
