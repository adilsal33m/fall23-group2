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
import SwiftData

@Observable
class AddParticipantViewVM: ObservableObject{
    var search = ""
    var selectedParticipants:[User] = []
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
    
    func addUserToSelection(user: User) {
        // Check if the user is not already in the selection
        if !selectedParticipants.contains(user) {
            selectedParticipants.append(user)
        }
    }
    
    func printU(){
        print(selectedParticipants)
    }
}
