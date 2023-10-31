//
//  LoginViewVM.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation
import Firebase
class LoginViewVM: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    
//    init(){
//        FirebaseApp.configure()
//    }
    
    func login(){
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if error != nil {
                print("some eerero")
//                print(error!.localizedDescription)
            }
            
            if (result != nil) {
                print("useer logged in")
                print(result?.user.email ?? "USER LOGGED IN")
            }
        }
        
        
        
    }
    
        
    func validate () -> Bool{
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            print("theree is some error")
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            print("this is not a valid email")
            
            return false
        }
        return true
    }
}
