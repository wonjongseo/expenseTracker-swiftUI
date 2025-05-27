//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Jongseo Won on 5/25/25.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject  var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
