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

class AddExpenseViewVM: ObservableObject{
    @Published var BillDesc = ""
    @Published var totalString = ""
    @Published var Total = 0.0
    
    var db = Firestore.firestore()
    
    @Published var users:[User] = []
    
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
