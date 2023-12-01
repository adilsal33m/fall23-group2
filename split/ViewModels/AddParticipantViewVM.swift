//
//  AddParticipantViewVM.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine

class AddParticipantViewVM: ObservableObject{
    @Published var search = ""
    
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
