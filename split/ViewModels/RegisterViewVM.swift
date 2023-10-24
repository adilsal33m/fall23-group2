//
//  RegisterViewVM.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation
import Firebase

class RegisterViewVM: ObservableObject{
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    init(){
        FirebaseApp.configure()
    }
    
    func register () {
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if error != nil{
                print("there is some error")
            }
        }
    }
}
