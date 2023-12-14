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
import SwiftData

@Observable
class SplitBillViewVM: ObservableObject{
    
//    var total_amount = 0
    let db = Firestore.firestore()
    var currentUser: User?
//    var percentages:[Double] = []
    var createdBy = Auth.auth().currentUser?.email ?? "anon"
    
        
    func createExpenseEntry(percentages:[Double], total_amount:Int, id: [User]){
        let amounts = calculateAmounts(percentages: percentages, total_amount: total_amount)
//        let friend1 = Friends(id: "12341", amount: 1200)
//        let friend2 = Friends(id: "12342", amount: 1400)
//        var createdBy = Auth.auth().currentUser?.uid ?? "anon"
        var friends: [Friends] = []
            
        for (index, amount) in amounts.enumerated() {
            let friend = Friends(id: id[index].id, email: id[index].email, amount: Int(amount), name: id[index].name)
            friends.append(friend)
        }
        let expense = Expense(createdBy: createdBy, name: "Restuarant", totalBill: total_amount, friends: friends)
        
        do {
            print("here")
            _ = try db.collection("Expense").document(createdBy).setData(from: expense)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }

        
    }
    
    func calculateAmounts(percentages:[Double], total_amount:Int) -> [Double] {
        let totalPercentage = percentages.reduce(0, +)

        guard totalPercentage == 100 else {
            fatalError("Percentages must add up to 100")
        }

        let amounts = percentages.map { percentage in
            (percentage / 100) * Double(total_amount)
        }

        return amounts
    }
    
        
    func fetchUser(email: String, completion: @escaping (User?) -> Void) {
        // Reference to the Firestore "users" collection
        let usersCollection = db.collection("Users")
        print(email.prefix(1).capitalized + email.dropFirst())
        // Query for the user with the specified UID
        usersCollection.whereField("email", isEqualTo: email.prefix(1).capitalized + email.dropFirst()).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting user document: \(error)")
                completion(nil)
            } else {
                // Process the snapshot to get the user data
                if let document = snapshot?.documents.first,
                   let user = try? document.data(as: User.self) {
                    self.currentUser = user
                    completion(user)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    
    func sentBill(email:String, friends: [User], completion: @escaping (User?) -> Void){
        var friendsUID:[String] = []
//        var email = ""
        
        
        for(_,user) in friends.enumerated(){
            friendsUID.append(user.email)
        }

        let usersCollection = db.collection("Users")
        print(email.prefix(1).capitalized + email.dropFirst())
        // Query for the user with the specified UID
        usersCollection.whereField("email", isEqualTo: email.prefix(1).capitalized + email.dropFirst()).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting user document: \(error)")
                completion(nil)
            } else {
                // Process the snapshot to get the user data
                if let document = snapshot?.documents.first,
                   var user = try? document.data(as: User.self) {
                    user.OwesYou = friendsUID
//                    self.currentUser = user
                    do {
                        print("this")
                        try usersCollection.document(document.documentID).setData(from: user)
                        // Optionally, update the local currentUser property
//                        self.currentUser = user
                        completion(user)
                    } catch {
                        print("Error updating user document: \(error)")
                    }
                    
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    
    
    func receiveBill(friendsUID:[User], completion: @escaping (User?) -> Void){
        
        for (_, participant) in friendsUID.enumerated(){
            
            let email = participant.email
            
            
            let usersCollection = db.collection("Users")

            // Query for the user with the specified UID
            usersCollection.whereField("email", isEqualTo: email.prefix(1).capitalized + email.dropFirst()).getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting user document: \(error)")
                    completion(nil)
                } else {
                    // Process the snapshot to get the user data
                    if let document = snapshot?.documents.first,
                       var user = try? document.data(as: User.self) {
                        if let id = Auth.auth().currentUser?.email{
                            print("something is not right")
                            print("ooser \(user)")
                            user.youOwe = user.youOwe ?? []
                            user.youOwe?.append(id)
                            
                        }
    //                    self.currentUser = user
                        do {
                            print("thissss")
                            try usersCollection.document(document.documentID).setData(from: user)
                            // Optionally, update the local currentUser property
                            self.currentUser = user
                            completion(user)
                        } catch {
                            print("Error updating user document: \(error)")
                        }
                        
                    } else {
                        completion(nil)
                    }
                }

            }
        }
    }
}
