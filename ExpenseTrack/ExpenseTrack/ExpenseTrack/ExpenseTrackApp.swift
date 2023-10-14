// ExpenseTrackApp.swift

import SwiftUI

@main
struct ExpenseTrackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ExpenseManager())
        }
    }
}
