//
//  splitApp.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI
import Firebase
import Combine

@main
struct splitApp: App {
    @StateObject var viewModel = AddParticipantViewVM()
    @StateObject var SplitViewModel = SplitBillViewVM()
    @StateObject var ExpenseViewModel = AddExpenseViewVM()
    init() {
            FirebaseApp.configure()
        }


    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .environment(SplitViewModel)
                .environment(ExpenseViewModel)
        }
    }
}
