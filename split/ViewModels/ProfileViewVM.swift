//
//  ProfileViewVM.swift
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
class ProfileViewVM: ObservableObject{
    
    var db = Firestore.firestore()
    
    //    var users:[User] = []
    
    var usersOweEmails:[String] = []
    
    var usersYouOweEmails:[String] = []
    
    var usersYouOwe:[User] = []
    
    var expenseFriends:[Friends] = []
    
    var expense:Expense?
    
    var expensesYouOwe:[Expense] = []
    
    
    
    func fetchExpense(email:String, completion: @escaping (Expense?) -> Void){
        // Reference to the Firestore "users" collection
        let usersCollection = db.collection("Expense")
        print(email.prefix(1).capitalized + email.dropFirst())
        // Query for the user with the specified UID
        usersCollection.whereField("createdBy", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting user document: \(error)")
                completion(nil)
            } else {
                // Process the snapshot to get the user data
                if let document = snapshot?.documents.first,
                   let expense = try? document.data(as: Expense.self) {
                    //                    self.currentUser = user
                    self.expense = expense
                    self.expenseFriends = expense.friends
                    completion(expense)
                } else {
                    completion(nil)
                }
            }
        }
        
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
                    //                    self.currentUser = user
                    completion(user)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    
    
    
    //    func bifercate(user:User) -> ([String],[String]){
    //
    //
    //        var owes_you:[String] = []
    //
    //        var you_owe:[String] = []
    //
    //        if let owes = user.OwesYou{
    //            owes_you = owes
    //        }
    //
    //        if let youOwe = user.youOwe{
    //            you_owe = youOwe
    //        }
    //
    //        return (owes_you, you_owe)
    //    }
    
    // fetch users based on these arrays
    
    // store the users in seperate arrays
    
    // on the view side 2
    
    //    func fetchEmails(email:String){
    //
    //
    //        let usersCollection = db.collection("Users")
    //        print(email.prefix(1).capitalized + email.dropFirst())
    //        // Query for the user with the specified UID
    //        usersCollection.whereField("email", isEqualTo: email.prefix(1).capitalized + email.dropFirst()).getDocuments { snapshot, error in
    //            if let error = error {
    //                print("Error getting user document: \(error)")
    ////                completion(nil)
    //            } else {
    //                // Process the snapshot to get the user data
    //                if let document = snapshot?.documents.first,
    //                   let user = try? document.data(as: User.self) {
    //
    //                    if let emails = user.OwesYou{
    //                        self.usersOweEmails = emails
    //                    }
    //                    if let others = user.youOwe{
    //                        self.usersYouOweEmails = others
    //                    }
    //                    //                        self.currentUser = user
    ////                    completion(user)
    //                } else {
    ////                    completion(nil)
    //                }
    //            }
    //        }
    //
    //    }
    
    func fetchEmails(email: String, completion: @escaping (Bool) -> Void) {
        let usersCollection = db.collection("Users")
        
        usersCollection.whereField("email", isEqualTo: email.prefix(1).capitalized + email.dropFirst())
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting user document: \(error)")
                    completion(false)
                } else {
                    if let document = snapshot?.documents.first,
                       let user = try? document.data(as: User.self) {
                        self.usersOweEmails = user.OwesYou ?? []
                        self.usersYouOweEmails = user.youOwe ?? []
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
    }
    
    
    func fetchOwesUsers(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        for (_, email) in usersOweEmails.enumerated() {
            dispatchGroup.enter()
            
            let usersCollection = db.collection("Users")
            usersCollection.whereField("email", isEqualTo: email.prefix(1).capitalized + email.dropFirst()).getDocuments { snapshot, error in
                defer {
                    dispatchGroup.leave()
                }
                
                if let error = error {
                    print("Error getting user document: \(error)")
                } else {
                    if let document = snapshot?.documents.first,
                       let user = try? document.data(as: User.self) {
                        self.usersYouOwe.append(user)
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All users fetched")
            completion()
        }
    }
    
    
    // -> take emails from users you owe
    //    -> search expense table for the user "createdBy"
    //    -> take the amount from there
    
    //    if L@split.com owes money to k@k.com this means that k@k.com has an entry in expense table with L@split.com with the amount in the friends array[implementation]
    
    //    the user that is signed in at the moment will be fetched. his user table contains who he owes money to and then the above logic will be applied
    
    func fetchUserYouOwe(completion: @escaping () -> Void){
        let dispatchGroup = DispatchGroup()
        print("you owe: \(usersYouOweEmails)")
        print(usersOweEmails)
        for (_, email) in usersYouOweEmails.enumerated() {
            dispatchGroup.enter()
            
            let expenseCollection = db.collection("Expense")
            expenseCollection.whereField("createdBy", isEqualTo: email).getDocuments { snapshot, error in
                defer {
                    dispatchGroup.leave()
                }
                
                if let error = error {
                    print("Error getting expense document: \(error)")
                } else {
                    if let document = snapshot?.documents.first,
                       let expense = try? document.data(as: Expense.self) {
                        self.expensesYouOwe.append(expense)
                        //                        self.usersYouOwe.append(expense)
                        
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All expenses fetched")
            completion()
        }
    }
    
    
}
