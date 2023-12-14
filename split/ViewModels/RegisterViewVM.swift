//
//  RegisterViewVM.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class RegisterViewVM: ObservableObject{
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
//    @Published var id = ""
    let db = Firestore.firestore()
    
        
//    init(){
//        FirebaseApp.configure()
//    }
    
//    func register () {
//        Auth.auth().createUser(withEmail: email, password: password) {result, error in
//            if error != nil{
//                print("there is some error")
//            }
//        }
//    }
    
    
    func register(completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error during registration: \(error.localizedDescription)")
                completion(false)
            } else {
                // Registration successful
                completion(true)
            }
        }
    }
    
    func addUser() {
        let user = User(id: UUID(), email: email, name: name)

        do {
            _ = try db.collection("Users").document(email).setData(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }

}
