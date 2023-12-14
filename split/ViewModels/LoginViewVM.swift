//
//  LoginViewVM.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

@MainActor
class LoginViewVM: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    
//    init(){
//        FirebaseApp.configure()
//    }
    
    
    func signInGoogle() async throws {
        guard let topVC = await Utilities.shared.topViewController() else {
            throw URLError(.badURL)
        }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
                
        GIDSignIn.sharedInstance.configuration = config
        
        let gidResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidResult.user.idToken?.tokenString else {
            throw URLError(.badURL)
        }
        
        let accessToken: String = gidResult.user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        try await Auth.auth().signIn(with: credential)
        
        
    }
    
    func login(completion: @escaping (Bool) -> Void){
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if error != nil {
                print("some eerero")
//                print(error!.localizedDescription)
                completion(false)
            }
            
            if (result != nil) {
                print("useer logged in")
                print(result?.user.email ?? "USER LOGGED IN")
                completion(true)
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
