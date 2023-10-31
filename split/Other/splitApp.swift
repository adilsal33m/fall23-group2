//
//  splitApp.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI
import Firebase

@main
struct splitApp: App {
    
    init() {
            FirebaseApp.configure()
        }


    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
